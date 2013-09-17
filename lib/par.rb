############################################################
#
#  par.rb for Xilinx ISE Place & Route Operation
#
#   Author    : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#   Date      : 2009/08/17
#   Version   : 0.1
#
############################################################
require "message"

class Par < Message
  def initialize()
  end


  def exe_par
    printf("@I:Execute Par operaion using Xiinx ISE\n")
    @path = Dir::pwd
    @syn_dir  = $WORK_DIR + "/rev_" + $PROJECT
    @par_dir  = @syn_dir + "/ISE"
    @edif2ngd = "edif2ngd -intstyle ise \"" +  @syn_dir + "/" + $PROJECT + ".edf\" " 
    @ngdbuild = "ngdbuild -intstyle ise -dd _ngo  -nt timestamp -p xc4vlx80-ff1148-10 \"" + @syn_dir + "/" + $PROJECT + ".edf\" " + $PROJECT + ".ngd -uc " + @syn_dir + "/synplicity.ucf"  
    @map      = "map -intstyle ise -p xc4vlx80-ff1148-10 -detail -cm speed -ol high -timing -pr off -t 1 -c 100 -o " + $PROJECT + "_map.ncd " + $PROJECT + ".ngd " + $PROJECT + ".pcf"
    @par      = "par -w -intstyle ise -pl high -rl high -t 1 " + $PROJECT + "_map.ncd " + $PROJECT + ".ncd " + $PROJECT + ".pcf"
    @trce     = "trce -intstyle ise -v 1000 -timegroups -u 100 -a -s 10 -xml " + $PROJECT + " " + $PROJECT + ".ncd -o " + $PROJECT + ".twr " + $PROJECT + ".pcf -ucf " + @syn_dir + "/synplicity.ucf"

    printf("@I:Making ISE directory \"%s\"\n",@par_dir)
    if FileTest::exist?("#{@par_dir}")
#      $NOTE_CNT += 1
#      printf("@N:%s is already exist\n",@par_dir)
    else
      Dir::mkdir("#{@par_dir}")
    end
    Dir::chdir("#{@par_dir}")

#    printf("@I:Execute edif2ngd \"%s\"\n",@edif2ngd)
#    system("#{@edif2ngd}")

    printf("@I:Execute ngdbuild \"%s\"\n",@ngdbuild)
    if $VERBOSE == true
      cmd = "#{@ngdbuild}"
    else 
      cmd = "#{@ngdbuild} >& /dev/null" 
    end
    if system("#{cmd}") == false
      printf("@E:ngdbuild is abnormally finished\n")
      exit
    end

    printf("@I:Execute map \"%s\"\n",@map)
    if $VERBOSE == true
      cmd = "#{@map}"
    else 
      cmd = "#{@map} >& /dev/null" 
    end
    if system("#{cmd}") == false
      printf("@E:map is abnormally finished\n")
      exit
    end

    printf("@I:Execute par \"%s\"\n",@par)
    if $VERBOSE == true
      cmd = "#{@par}"
    else 
      cmd = "#{@par}  >& /dev/null" 
    end
    if system("#{cmd}") == false
      printf("@E:par is abnormally finished\n")
      exit
    end

    printf("@I:Execute trce \"%s\"\n",@trce)
    if $VERBOSE == true
      cmd = "#{@trce}"
    else 
      cmd = "#{@trce}  >& /dev/null" 
    end
    if system("#{cmd}") == false
      printf("@E:trce is abnormally finished\n")
      exit
    end

    Dir::chdir("#{@path}")
    
  end

end
