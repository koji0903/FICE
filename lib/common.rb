#!/usr/bin/ruby
##################################################################
#
#  Common
#
#  Function : Describe common function
#
#  Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#  Date     : 2012/09/06
#
#  History
#    
#
###################################################################
#
# [OPERATION]
#
# 1. file_read(file_name)
#     - func   : read file and save array data
#     - param  : file_name.str   - Input file name
#     - return : file_data.Array - Data Array
#
# 2. file_write(file_name)
#
#
# 3. data_trim(indata)
#     - func   : trimming comment line(#) and nil line
#     - param  : idata.Array
#     - return : odata.Array
#
# 4  make_dir(dir_name)
#     - func   : make directory in current directory
#     - param  : directory name you want
#     - return : result(true/false)
#
# 5. remove_after
#     - func   : remove string after described charactor
#     - param  : line - original string
#                str  - charactor
#
# 6. search_file(dir,extension)
#     - func   : search file under direcotry
#     - param  : dir  - directory name(default:".")
#              : extension - extension(default:"*.*")
#
# 7. chk_argument(argument,param)
#     - func   : check arugument
#     - param  : argument - argument name
#              : param - parameter
#
# 8. chk_file
#     - func   : check file exist or not
#     - param  : file - File name 
#
#
###################################################################
require "system"
require "find"
require "fileutils"

$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$INTERNAL_ERROR_CNT = 0

module Common

  #
  # initialize
  #
  def initialize
  end

  #
  # file_read
  #
  def Common.file_read(file_name,message="on",num=0)
    printf("@I:read %s\n",file_name) if message=="on"
    file_data = Array.new
    begin
      f = open("#{file_name}","r")
      while line = f.gets
#        line = line.sub("\n","") # Delete "\n" code
        line = line.chomp # Delete "\n" code
        line = line.force_encoding("EUC-JP") if RUBY_VERSION == "1.9.2"
        if num == 0
          file_data << line
        else
          file_data << line if line.size != 0 
        end
      end
    rescue => ex
      puts ex.message
      exit 1
    end
    return file_data
  end # def read

  #
  # data_trim
  #
  def Common.data_trim(idata)
    odata = Array.new
    idata.each{|line|
      next if /^#/ =~ line     # delete "#" line
      next if line.size == 0   # delete no-size line
      line = line.gsub(" ","") # delete space
      odata << line
    }
    return odata
  end

  #
  # make_dir
  #
  def Common.make_dir(dir_name,num=0)
#    printf("@I:make working direcory \"%s\"\n",dir_name)
    result = nil
    if num == 0
#      work_path = File.expand_path(dir_name)
#      pp work_path
#      exit
      current_path = Dir.pwd
      work_path = current_path + "/" + dir_name
    else
      work_path = dir_name
    end
    if FileTest::directory?(work_path) == false
      result = Dir::mkdir(work_path,0777)
      printf("@I:Make working direcory (%s)\n",work_path)
    end
    return result
  end

  def Common.make_dir_with_delete(dir_name,num=0)
#    printf("@I:make working direcory \"%s\"\n",dir_name)
    result = nil
    if num == 0
      current_path = Dir.pwd
      work_path = current_path + "/" + dir_name
    else
      work_path = dir_name
    end
    if FileTest::directory?(work_path) == false
      result = Dir::mkdir(work_path)
      printf("@I:Make working direcory (%s)\n",work_path)
    else
      Dir::glob("#{dir_name}/*").each{|name|
        if FileTest::directory?(name) == false
          File.delete("#{name}")
        else
          Dir::rmdir(name)
        end
      }
      Dir::rmdir(work_path)
      result = Dir::mkdir(work_path)
      printf("@I:Make working direcory (%s)\n",work_path)
    end
    return result
  end

  def Common.del_dir(dir_name)
    dirlist = Dir::glob(dir_name + "**/").sort {
      |a,b| b.split('/').size <=> a.split('/').size
    }
    dirlist.each {|d|
      Dir::foreach(d) {|f|
        if FileTest::directory?(d+f) == false 
          File::delete(d+f) if ! (/\.+$/ =~ f)
        else
          Common.del_dir(d+f) if ! (/\.+$/ =~ f)
        end
      }
      Dir::rmdir(d)
    }
  end

  #
  # Collect files
  #  param  : directory name
  #  return : file list(array)
  #
  def Common.collect_verilog_files(dir_name)
    if FileTest::directory?(dir_name)
      file_list = Array.new
      Dir::glob("#{dir_name}/*.v").each {|f|
        file_list << f 
      }
      Dir::glob("#{dir_name}/*.hdl").each {|f|
        file_list << f 
      }
      # remove linux direcotry
      file_list.delete("")
      file_list = file_list.sort
      return file_list
    else
      $ERROR_CNT += 1
      printf("@E:Not found \"%s\" directory.\n",dir_name)
      print_summary
    end
  end

  #
  # remove the string after describe character in each line
  #
  def Common.remove_after(line,str)
    tmp = line
    if /#{str}/ =~ line
      num = line.index("#{str}")      
      tmp = line.slice(0,num) if num != nil
      return tmp
    end
    return line
  end
#  def Common.remove_after(line,str)
#    tmp = str
#    if /#{str}/ =~ line 
#      num = line.index("#{tmp}")
#      num = line.index("\/\/")
#      line = line.unpack("a.:#{num}") 
#      return line[0]
#    end
#    return line
#  end

  #
  # search file
  #
  def Common.search_file(dir=".",extension=nil)

    file_list = Array.new
    if extension != nil
      ext = "." + extension
    end
    Find.find(dir){|path|
      if extension == nil
        file_list << path if File.file?(path)
      else
        if File.extname("#{path}") == ext
          file_list << path
        end
      end
    }
    return file_list
  end

  #
  # print
  # 
  def Common.print_base
    printf("%s(%s) ver:%s",$TOOL,$SUB_TOOL,$VERSION)
    revision,branch = get_revision($0)
    if /trunk/ =~ $VERSION && revision != nil
      printf(" [ %s -  Commit Hash : %s ]\n",branch,revision)
    else
      printf("\n")
    end
    printf("Copyright (c) 2009-2012 Renesas Micro Systems. All rights reserved.\n")
    # Get Start Time
    $StartTime = Time.now 
    printf("  - Started Time : %s\n\n",$StartTime)
  end

  def Common.print_summary
    printf("\n")
    printf("Execution Result\n")
    printf("   Note     : %4d\n", $NOTE_CNT)
    printf("   Warning  : %4d\n", $WARNING_CNT)
    printf("   Error    : %4d\n", $ERROR_CNT)
    printf("\n")
    printf("   Internal Error    : %4d\n", $INTERNAL_ERROR_CNT)
    printf("\n")
    if $ERROR_CNT == 0 && $INTERNAL_ERROR_CNT == 0
      if $SUB_TOOL != nil
        printf("%s(%s) has successfully finished.\n\n\n",$TOOL,$SUB_TOOL)
      else
        printf("%s has successfully finished.\n\n\n",$TOOL)
      end
    else
      if $SUB_TOOL != nil
        printf("%s(%s) finished with Errors. please check error message.\n\n\n",$TOOL,$SUB_TOOL)
      else
        printf("%s finished with Errors. please check error message.\n\n\n",$TOOL)
      end
    end
    # Get End Time
    $EndTime = Time.now
    if $StartTime != nil && $EndTime != nil
      days = ($EndTime - $StartTime).divmod(24*60*60)
      hours = days[1].divmod(60*60) 
      mins = hours[1].divmod(60)
      

      print <<EOB
Process took #{hours[0].to_i} hours #{mins[0].to_i} minutes #{mins[1].to_i} seconds
 ( Start Time : #{$StartTime}, End Time : #{$EndTime} )


EOB

    end
  end

  def Common.get_revision(file_name)
    current_dir = Dir.pwd
    file_name = File.expand_path(file_name)
    Dir.chdir(File.dirname(file_name))
    git_path = "/home/product/div-micom-ice/data/proj/RL78/Common/local/git/bin/git"
    begin
      hash_value = `#{git_path} log --pretty=format:"%h" -n 1`
      branch_all = `#{git_path} branch --no-color`
    rescue
      hash_value = ""
      branch_all = ""
    end
    branch = nil
    branch_all.split("\n").each do |line|
      if /\*\s+(.+)/ =~ line
        branch = $1
      end
    end
    Dir.chdir(current_dir)
=begin
    if result != nil
      result = result.split("\n")
      result.each do |line|
        if /^Revision:\s+(.+)/ =~ line
          return $1
        end
      end
    end
    return nil
=end
    return hash_value.to_s, branch.to_s
  end

  def Common.print_file_header(f, str, sub_tool, ver = $VERSION,c = "#", command = nil)
    25.times{
      f.printf("%s",c)
    }
    f.printf("\n")
    f.printf("%s\n",c)
    f.printf("%s %s\n",c,str)
    unless $TEST_MODE
      if sub_tool != nil
        f.printf("%s   Generated by %s(%s) ver %s",c,$TOOL, sub_tool, ver )
      else
        f.printf("%s   Generated by %s ver %s",c,$TOOL, ver )
      end
      revision,branch = get_revision($0)
      if /trunk/ =~ ver && revision != nil
        f.printf(" [ %s - Commit Hash : %s ]\n",branch,revision)
      else
        f.printf("\n")
      end
      f.printf("%s   time : %s\n",c,Time.new)
    end
    if command != nil
    f.printf("%s   cmd  : %s\n",c,command)
    end
    f.printf("%s\n",c)
    25.times{
      f.printf("%s",c)
    }
    f.printf("\n\n")
  end

  #
  # chk_argument
  #
  def Common.chk_argument(argument,param)
    if param == nil
      printf("@E:\"%s\" option was not specified.\n",argument)
      return 1
    end
    return 0
  end

  def Common.internal_error(file,line)
    $INTERNAL_ERROR_CNT += 1
    printf("@Internal Error (%s:%d)\n",file,line)
    exit 1
  end

  #
  # print_arugment
  #
  def Common.print_argument(argument,param)
    printf("  %s :  %s\n",argument,param)
  end

  #
  # chk_file
  #
  def Common.chk_file(argument,file)
    if file == nil
      $ERROR_CNT += 1
      if argument != nil
        printf("@E: Need specify file after \"%s\" option\n",argument)
      else
        printf("@E: The file is not exist on the path.\n",file,argument)
      end
      return 1
    end
    if FileTest::file?(file) == false
      $ERROR_CNT += 1
      if argument != nil
        printf("@E: %s file which is defined \"%s\" is not exist on the path.\n",file,argument)
      else
        printf("@E: %s file is not exist on the path.\n",file,argument)
      end
      return 1
    end
    return 0
  end

  #
  # File Detail Information
  # 
  def Common.print_file_details(f,file,file_inf,delimiter="#")
    f.printf("%s %s (%s)\n",delimiter,file,file_inf.mtime)
  end

  #
  # Error operation
  #
  def Common.error(file=nil,line=nil)
#    $INTERNAL_ERROR_CNT += 1
    printf("@Internal Error (%s:%d)\n",file,line)    
    Common.print_summary
    exit 1
  end

  # md5sum
  #  param : file
  #  ret   : md5sum(String)
  def Common.md5sum(file)
    if File.readable?(file)
      return `md5sum #{file}`.split[0].to_s
    else
      return nil
    end
  end

  # md5sum-check
  #  param : file,md5sum
  #  ret   : md5sum(String)
  def Common.md5sum_check(file,md5sum)
    tmp = "tmp.txt"

    f = open("#{tmp}","w")
    f.printf("%s  %s\n",md5sum,file)
    f.close
    result = system("md5sum -c #{tmp}")
    FileUtils.rm("#{tmp}")
    return result
  end

  #
  # Resolve Full-path
  #
  def Common.resolve_FullPath(path)
    if path[0..1] == "./"
      path = path.sub(".","")
      path = Dir::pwd + path
    elsif path[0] == "/"
      path = path
    else
      path = Dir::pwd + "/" + path
    end 
    return path
  end

  #
  # Get Real Path
  #  Funk : Resolve Synbolic Link
  #
  def Common.get_RealPath(path)
    if File.exist?(path)      
      if File.ftype(path) == "link" && /\./ !~ path.split("/").last
        scope =  `ls -l #{path}`.split.last
        tmp = path.split("/")
        tmp[tmp.size-1] = scope
        get_RealPath(tmp.join("/"))
      else
        path = path.gsub("\/.\/","\/")
        return path
      end
    else
      printf "@E: %s does not exist or cannot access.\n",path
      return path
    end
  end


end

#
# Basic Conf Paser
#
private
class BasicParser
  def initialize(src)
    @src = src
  end
  def lex
    case @src
    when /^[\r\n\t ]*([${}\/0-9.a-zA-Z_-]+)(.*$)/      # number
    when /^[\r\n\t ]*(#+)(.*$)/      # comment
    when /^[\r\n\t ]*(\w+)(.*$)/         # alphabet
    when /^[\r\n\t ]*([\[\]\"\(\)\,\;\:])(.*$)/  # delimiter({,},[,])
    when /^[\r\n\t ]*(\=+|\|\||\!\=|\&\&|\||\&)(.*$)/         # delimiter({,},[,])
    when /^[\r\n\t ]+(.*)(.*$)/          # ==
      return nil
    end
    @src = $2
    $1
  end
  
  def tokens
    ts = Array.new
    while (token = lex) != nil
      ts.push(token)
    end
    ts
  end

  def Common.set_cell(sheet,color,border=nil)
    default_format = sheet.default_format
    cell = default_format.clone
    cell.pattern = 1
    cell.pattern_fg_color = color
    cell.border_color = :black
    cell.border = border unless border.nil?
    return cell
  end

end
