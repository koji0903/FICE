########################################################################
#
# FMake Logic Control Class
#
#    Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
########################################################################
#
#  Class Name : FMakeVerilogList
#  
#  [Input]
#    - Verilog List file
# 
########################################################################
require "FMakeMessage"
require 'FICE_DB'
require 'common'
require 'XMLParse'
require 'conv'

#
# FMake Logic
#
class FMakeVerilogList
  attr_accessor :v2xml_define
  attr_accessor :v2xml_define_base
  attr_accessor :ModuleList
  def initialize(inf)
    @filelist = inf[:filelist]
    outdir = inf[:outdir]
    if @filelist == nil
      FMakeMessage::PrintError( :category => "CONF", :no => 137 )
    end
    @v2xml_define_base = "./" + File.basename(@filelist,".list") + "_v2xml_define.v"
    if outdir == nil
      @v2xml = File.basename(@filelist,".list") + "_v2xml.v"
      @v2xml_define = File.basename(@filelist,".list") + "_v2xml_define.v"
    else
      @v2xml = outdir + "/" + File.basename(@filelist,".list") + "_v2xml.v"
      @v2xml_define = outdir + "/" + File.basename(@filelist,".list") + "_v2xml_define.v"
      if outdir != "." && outdir != Dir::pwd
        Common.make_dir(outdir,1)
      end
    end

    @xml_base = inf[:xml_base]
    @Product = inf[:product]
    unless inf[:db_file].nil?
      @DB_FILE = inf[:db_file]
    else
      @DB_FILE = "rl78_" + @Product + ".db"
    end
    @Dev_Ver = inf[:dev_ver]
    @ICE_Ver = inf[:ice_ver]


    @xml_file = FICE_DB::FICE_DATA + "/xml/" + @xml_base
    if @ICE_Ver == nil
      @hdl_path = FICE_DB::FICE_DATA + "/hdl/" + @Product + "_" + @Dev_Ver
    else
      @hdl_path = FICE_DB::FICE_DATA + "/hdl/" + @Product + "_" + @Dev_Ver + "_" + @ICE_Ver
    end
    Dir::mkdir(@hdl_path,0777) if FileTest::directory?(@hdl_path) == false
    @search_max_hier = 2

    @module_inst = Hash.new # "moudle_name" => ["inst list"]
    @module_file = Hash.new # "module_name" => "link path"
    
    @RUN_V2XML = false
    @V2XML_define_opt = "--output-define-file"

    @ModuleList = Hash.new
    @List_MD5SUM = nil
  end
  
  # save
  #  - Read Each HDL file in VerilogList
  #  - Copy HDL File to .fice
  #  - Create DB for rl78.db
  public
  def analyze_VerilogList
    printf("@I:analyze VerilogList File (%s)\n",@filelist)
    already_hdl = Array.new
    # SQLite3 - RL78.db , table: Logic
    db = FICE_DB::Logic.new( :db_file => @DB_FILE, :product => @Product)

    v2xml = open(@v2xml,"w")
    # Special Define
#    v2xml.printf("`define FLASH_ASSERT_OFF\n")

#    readme_file = @hdl_path + "/ReadMe.txt" 
#    readme = open(readme_file,"w")
    # read hdl files
    file_no = 1
    file_inf = Array.new
    list_update_flag = false
    FMakeMessage::PrintError( :category => "CONF", :no => 138, :file => @filelist) unless FileTest::readable?(@filelist)
    @List_MD5SUM = Common.md5sum(@filelist)
    open(@filelist,"r").each do |file|
      file = file.strip
      # Blank Line
      next if file.size == 0
      # "//"
      next if /^\/\// =~ file
      # "#"
      next if /^#/ =~ file
      # file does not exist
      unless FileTest.readable?(file)
        # ERROR and EXIT
        FMakeMessage::PrintError( :category => "FILE", :no => 20, :param => file, :read_file => @filelist, :line_no => file_no )
      end
      # Analyze Module Name
      contents = Conv.new(file).main
      contents.split("\n").each do |line|
        line = line.gsub("\t"," ")
        if /^\s*module\s+(\w*)\s*\(/ =~ line
          module_name = $1.strip
          @ModuleList[module_name] = file
        elsif /^\s*module\s+(\w*)\s*$/ =~ line
          module_name = $1.strip
          @ModuleList[module_name] = file
        end
      end unless contents.nil?

      # Satus Defalt Setting
      status = "new"

      # Get hdl_data
      hdl = open(file,"r"); contents = hdl.read; hdl.close
      # Get base_name
#      base_name = File.basename(file).split(".")[0]
      # Get hdl_md5sum
      hdl_md5sum = Common.md5sum(file)

      # make copy file path
      copy_file = @hdl_path + "/" + File.basename(file)
      # File Copy to FICE_DB Path
      begin
        FileUtils.install(file,copy_file, :mode => 0666)
      rescue
      end
#      readme.printf("%s from %s\n",File.basename(copy_file),file)

      #--- Special Func ( Skip for sv ) #
      if File.extname(file) == ".sv"
        $WARNING_CNT += 1
        printf("@W:Skip %s for V2XML\n",file)
        next
      end

      # Chck md5sum & v2xml ver
#      db_v2xml_ver, db_hdl_md5sum, xml_path = db.check_file(file)
      base_path = File.basename(file)
      db_file, db_v2xml_ver, xml_path, list_md5sum  = db.check_md5sum(base_path,hdl_md5sum,@Product,@Dev_Ver,@ICE_Ver)
#      next if File.stat(file).blocks == 0
      if already_hdl.index("#{file}") == nil
        if FICE_DB::V2XML_VER == db_v2xml_ver && base_path == db_file && xml_path != nil && @List_MD5SUM == list_md5sum
          # Same        
          v2xml.printf("`include \"%s\" // Already Converted\n",file) # output comment out 
        else
          if @List_MD5SUM != list_md5sum
            printf("@I:List File Updated(#{@List_MD5SUM},#{list_md5sum}).\n") unless list_update_flag
            list_update_flag = true
          end

          # for V2XML
          printf("@I:Found new file (%s)\n",file)
          @RUN_V2XML = true # Execute V2XML
          status = "Update"
          v2xml.printf("`include \"%s\"\n",file)
          regist_hdl(base_path,db,status,nil,hdl_md5sum)
        end
        already_hdl << file
      end
      
#      regist_hdl(base_path,db,status,contents,hdl_md5sum)
#      file_inf << [base_path,status,contents,hdl_md5sum]
=begin
      # include check
      include_line = `grep include #{file}`
      if include_line != ""
        include_line = include_line.split("\n")
        include_line.each do |each_include|
          each_include.strip.gsub("\"","")
          /^`include\s+\"(.*)\"/ =~ each_include
          if $1 != nil
            include_file = $1
            if File.readable?(include_file)
              file = include_file
              status = "Update"
              # Get hdl_md5sum
              hdl_md5sum = Common.md5sum(file)              
              db_v2xml_ver, db_hdl_md5sum, xml_path = db.check_file(file)
              if FICE_DB::V2XML_VER == db_v2xml_ver && hdl_md5sum == db_hdl_md5sum && xml_path != nil
              else
                @RUN_V2XML = true
              end
              regist_hdl(file,db,status,contents,hdl_md5sum)
            end
          end
        end
      end
=end
      
      file_no += 1
    end

=begin
    if @RUN_V2XML
      # Delete table
      #      db.delete_table
      db = FICE_DB::Logic.new( :db_file => @DB_FILE, :product => @Product)
      printf("@I:Make New Table in FICE_DB")
      file_inf.each do |inf|
        regist_hdl(inf[0],db,inf[1],inf[2],inf[3])
      end
      # Make new table
      #      regist_hdl(file,db,status,contents,hdl_md5sum)
      
    end
=end
    v2xml.close
#    readme.close
    
    # Generate XML using V2XML & HTML using v2html
    make_xml_html





    return @xml_file
  end

  def regist_hdl(file,db,status,contents,hdl_md5sum)
    printf("@I:Regist %s\n",file) if $VERBOSE
    if @ICE_Ver == nil
      @ICE_Ver = "NONE"
    end
    db.regist_hdl(
                  :product    => @Product,
                  :dev_ver    => @Dev_Ver,
                  :ice_ver    => @ICE_Ver,
                  :status     => status,
                  :base_name  => File.basename(file),
                  :v2xml_ver  => FICE_DB::V2XML_VER,
                  :xml2v_ver  => FICE_DB::XML2V_VER,
                  :hdl_path   => File.basename(file),
                  :hdl_data   => contents,
                  :hdl_md5sum => hdl_md5sum,
                  :xml_path   => @xml_file,
                  :list_md5sum   => @List_MD5SUM
                  )
  end

  #
  # make_xml
  #
  private
  def make_xml_html

    # make xml directory
#    Common.make_dir_with_delete("xml")

    # Set Char Code
#    ENV['LC_ALL'] = "ja_JP.UTF-8"
    ENV['LC_ALL'] = "en_US"
    # Message
    printf("\n@I:Execute VerilogToXML ver %s(using %s -> xml:%s). \n",FICE_DB::V2XML_VER,@v2xml,@xml_file)
    printf("To complete this process takes a long time. please wait.\n")
    $TOP_XML_FILE = @xml_file

    # Execute V2XML
    result = nil
    v2xml_run_flag = nil
    xml_file_size =  FileTest.size?(@xml_file)
    if xml_file_size == nil
      xml_flag = true
    else
      if xml_file_size < 1000
        xml_flag = true
      else
        xml_flag = false
      end
    end
    if @RUN_V2XML || xml_flag
      v2xml_run_flag = true
    end
    t1 = Thread.new do
      if v2xml_run_flag
        printf "Command:#{FICE_DB::V2XML} #{@v2xml} #{@V2XML_define_opt} #{@v2xml_define} > #{@xml_file}\n"
        result = `#{FICE_DB::V2XML} #{@v2xml} #{@V2XML_define_opt} #{@v2xml_define} > #{@xml_file}`
        printf "V2XML Result : #{result}\n"
        open(@xml_file).each do |l|
          if /Parse error in ParseCompilerIndicators at/ =~ l
            FMakeMessage::PrintError( :category => "VerilogList", :no => 500, :xml => @xml_file )
          end
        end
        # Print Message
        printf("\n@I:Generated xml file (%s).\n",@xml_file)
        # File Copy 
        printf "@I:Copy Define File\n"
        printf " - FROM : #{@v2xml_define}\n"
        printf " - TO   : #{FICE_DB::FICE_DATA}/def/#{@v2xml_define_base}\n"
        FileUtils.install(@v2xml_define, FICE_DB::FICE_DATA + "/def/" + @v2xml_define_base, :mode => 0644)
        system("ls -l #{@xml_file}")
      else
        printf("@I:Skip execting VerilogToXML. Because All HDL-Files already converted to xml.")
        printf("- Already generated XML File is\n")
        printf "@I:Copy Define File\n"
        printf " - FROM   : #{FICE_DB::FICE_DATA}/def/#{@v2xml_define_base}\n"
        printf " - TO     : #{@v2xml_define}\n"
        FileUtils.install(FICE_DB::FICE_DATA + "/def/" + @v2xml_define_base, @v2xml_define, :mode => 0644)
        system("ls -l #{@xml_file}")
      end
    end

    # Execute V2HTML
    t2 = Thread.new do
=begin
      printf("\n@I:Execute VerilogToHTML\n")
      system("#{FICE_DB::V2HTML} -o #{FICE_DB::HTML_PATH}/v2html #{@v2xml} >/dev/null")
      hier_file = FICE_DB::V2HTML_OUTDIR + "/hierarchy-m.html"
      # get V2HTML Link at one module
      open(hier_file).each do |line|
        if /<a name=\"(.*)\"><\/a><a  href=\"(.*)\">(.*)<\/a>/ =~ line
          @module_file[$1] = $2
        end
      end
=end
    end

    # print "." message while executing V2XML
    t3 = Thread.new do
      while 1
        printf "."
        sleep 3
      end
    end

    # wait for finishing V2XML
    t1.join
    t2.join
    Thread::kill(t3)
    
    return true
  end

  #
  # Analyze Logic Structure
  #  param : top - Top Module Name
  public
  def generate_HierHtml(top,html=nil,max_hier_num=2)

    html = FICE_DB::HTML_PATH + "/hier.html" if html == nil
    printf("\n@I:Generating html file (%s). please wait.\n",html)
    f = open(html,"w")

    html = Array.new
    
    # Head
    f.print <<EOB
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=iso-8859-1"/>
	<title>jQuery treeview</title>	
	<link rel="stylesheet" href="./jquery/jquery.treeview.css" />
	<link rel="stylesheet" href="./jquery/demo/screen.css" />	
	<script src="./jquery/lib/jquery.js" type="text/javascript"></script>
	<script src="./jquery/lib/jquery.cookie.js" type="text/javascript"></script>
	<script src="./jquery/jquery.treeview.js" type="text/javascript"></script>	
	<script type="text/javascript" src="./jquery/demo/demo.js"></script>	
	</head>
	<body>

	<h4>Circuit Hierarchy</h4>
	
	<ul id="navigation">
EOB

    @root = XMLParse.read("#{@xml_file}")
    # Top-Module
    if get_ModuleFile(top) != nil
      hdl_path = FICE_DB::V2HTML_OUTDIR + "/" + get_ModuleFile(top)
    else 
      hdl_path = FICE_DB::V2HTML_OUTDIR + "/"
    end
    f.printf("<li><a href=\"%s\"  target=\"_blank\">%s</a>\n",hdl_path,top)
    get_InstanceList(f,@root,top,max_hier_num)
    printf "\n"
    f.printf("</li>\n")
    
    f.print <<EOB
</ul>
</div>
 
</body></html>
EOB
    html_size = f.size
    f.close
    return html_size
  end
  

  #
  # Get Instance List (Loop)
  #
  private
  def get_InstanceList(f,doc,module_name,max_hier_num,hire_num=2)
    printf "."
    module_list =  XMLParse::get_InstanceList(doc,module_name)
    # Sub-Module
    f.printf("<ul>\n") if module_list != []
    module_list.each do |sub_module|
      module_name = sub_module[0]
      inst_name = sub_module[1]
      next if /pull/ =~ inst_name
      module_file =  get_ModuleFile(module_name)
      if module_file == nil
        f.printf("<li>%s(%s)",inst_name,module_name)
      else
        hdl_path = FICE_DB::V2HTML_OUTDIR + "/" + module_file
        f.printf("<li><a href=\"%s\" target=\"_blank\">%s(%s)</a>",hdl_path,inst_name,module_name)
      end
      if hire_num < @search_max_hier
        # Search Low-order hierarchy
        get_InstanceList(f,doc,module_name,max_hier_num,hire_num+1)
      end
      f.printf("</li>\n") if module_list != nil
    end
    f.printf("</ul>\n") if module_list != []
  end

=begin   TEXT_VERSION

  #
  # Analyze Logic Structure
  # 
  public
  def analyze_Hier(top=nil)
    f = open("hier.txt","w")
    
    top = "D78F1070"
    @root = XMLParse.read("#{@xml_file}")
    # Top-Module
    f.printf("%s\n",top)
    get_InstanceList(f,@root,top)

    f.close
    return module_list.size
  end
  
  #
  # Get Instance List
  #
  private
  def get_InstanceList(f,doc,module_name,space=1)
    module_list =  XMLParse::get_InstanceList(doc,module_name)
    # Sub-Module
    module_list.each do |sub_module|
      next if /pull/ =~ sub_module[1]
      space.times do
        f.printf(" ")
      end
      f.printf("+%s(%s)\n",sub_module[1],sub_module[0])
      get_InstanceList(f,doc,sub_module[0],space+1)
    end
  end

=end

  private
  def get_ModuleFile(module_name)
    hier_file = FICE_DB::V2HTML_OUTDIR + "/hierarchy-m.html"
    open(hier_file).each do |line|
      if /<a name=\"#{module_name}\"><\/a><a  href=\"(.*)\">#{module_name}<\/a>/ =~ line
        return $1.to_s
      end
    end
    return nil
  end
  
end

class FMakeVerilogListCheck
  def initialize(inf)
    @NEW_LIST = inf[:new]
    @OLD_LIST = inf[:old]
  end
  def check
    new_data =  file_check(@NEW_LIST)
    old_data =  file_check(@OLD_LIST)
    # Added File
    if new_data.keys - old_data.keys != []
      printf("@I:Added Files.\n")
      (new_data.keys - old_data.keys).each do |file|
        printf("\t%s\n",file)
      end
    end
    # Deleted Files
    if old_data.keys - new_data.keys != []
      printf("@I:Deleted Files.\n")
      (old_data.keys - new_data.keys).each do |file|
        printf("\t%s\n",file)
      end
    end
    # Updated Files
    if old_data.keys & new_data.keys != []
      printf("@I:Updated Files.\n")
      (old_data.keys & new_data.keys).each do |file|
        if new_data[file] != old_data[file]
          printf("\t%s\n",file)          
        end
      end
    end
    
  end

  private
  def file_check(list_file)
    data = Hash.new
    # List File readable check
    unless FileTest.readable?(list_file)
      # ERROR and EXIT
      FMakeMessage::PrintError( :category => "FILE", :no => 20, :param => file, :read_file => @filelist, :line_no => file_no )
    end

    open(list_file,"r").each do |file|
      file = file.strip
      # Blank Line
      next if file.size == 0
      # "//"
      next if /^\/\// =~ file
      # "#"
      next if /^#/ =~ file
      # file does not exist
      unless FileTest.readable?(file)
        # ERROR and EXIT
        FMakeMessage::PrintError( :category => "FILE", :no => 20, :param => file, :read_file => @filelist, :line_no => file_no )
      end
      data[File.basename(file)] = Common.md5sum(file)
      if $VERBOSE
#        printf("%s:%s\n",File.basename(file),Common.md5sum(file))
      end
    end
    data
  end
end
