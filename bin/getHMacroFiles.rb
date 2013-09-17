#/usr/bin/ruby
##################################################
require 'find'
require 'fileutils'

class CollectHardMacroLibrary
  def initialize

    # path
    @Path = {
      :HMACRO_SS3RD => "/proj/78k0r_16/ss3rd/_macro/_1_local_release/_hard",
      :HMACRO_PATH  => "/proj/78k0r_11/78k0r_kx4/top_1.0/_macro/_hard",
    }
    
    # list
    @HMacroList = {
      :flash_code => "${HMACRO_SS3RD}/qnsa3n064k0v2_mf3_CF2.0_20100915-01",
      :flash_data => "${HMACRO_SS3RD}/qnsb3n004k0v2_mf3_CF2.0_20100915-01",
      :flash_cp   => "${HMACRO_SS3RD}/qnsc3ncp1v2_mf3_CF2.2_20101029-01",
      :flash_reg  => "${HMACRO_SS3RD}/qnsc3nreg1v2_mf3_CF2.0_20100915-01",
      :flash_capa => "${HMACRO_SS3RD}/qnsc3ncpdc0v1_mf3_CF2.0_20100915-01",
      :ram0       => "${HMACRO_PATH}/OWSRAM130W2048B18C4B9_mf3_1.00",
      :iobuf      => "${HMACRO_SS3RD}/HMG_IOBUF_SS3_KX4V2_mf3_v2.00_LR4.2.16_20100924",
      :cap        => "${HMACRO_SS3RD}/HMG_IOBUF_SS3_KX4V2_mf3_v2.00_LR4.2.16_20100924",
      :regm       => "${HMACRO_SS3RD}/qahregohnpoclviv2_mf3_v2.20_LR5.0.01_20110113",
      :regd       => "${HMACRO_SS3RD}/qahregohnpoclviv2_mf3_v2.20_LR5.0.01_20110113",
      :h_rosc     => "${HMACRO_SS3RD}/qahios0bn32mv2_mf3_v2.20_LR5.0.01_20110111/",
      :l_rosc     => "${HMACRO_PATH}/qahios1bn15kv1_mf3_v0.70/",
      :oscmain    => "${HMACRO_SS3RD}/qahmos0hnv1_mf3_v1.20_LR5.0.01_20110113",
      :oscsub     => "${HMACRO_SS3RD}/qahsos1hnv1_mf3_v1.10_20100730/",  
      :wwdt       => "${HMACRO_SS3RD}/qlk0rwwdt1v2_v2.20_LR3.0.01_20100820/",
      :rtc        => "${HMACRO_SS3RD}/qlk0rrtc0v3_v3.10_LR3.0.04_20100721/",
      :ad         => "${HMACRO_SS3RD}/qatada20hn032v1_mf3_v1.02_20100921/",
      :NoiseFilter50ns  => "${HMACRO_SS3RD}/tbfilter1x2_mf3_v1.02_20100730/",
      :NoiseFilter300ns => "${HMACRO_SS3RD}/qahnfi4bn300nv1_mf3_v1.12_20100730/",
      :vppts1_res => "${HMACRO_SS3RD}/HMG_IOBUF_SS3_KX4V2_mf3_v2.00_LR4.2.16_20100924"
    }
    
  end

  def resolve_path(path)
    if /\$\{(.*)\}.*/ =~ path
      str = $1.to_s
      resolve = @Path[:"#{str}"]
      if resolve.nil?
        printf("Cannot recognize path(%s)\n",str)
        exit
      else
        path = path.sub("\$\{#{str}\}","#{resolve}")
      end
    end
    return path
  end


  def main
    dir = "./_fv_files"
    # resolve path
    @HMacroList.each{|key,path|
      @HMacroList[:"#{key}"] = resolve_path(path)
    }
    # make dir
    Dir::mkdir("#{dir}", 0777) unless FileTest.directory?(dir)

    # find file & copy
    @HMacroList.each{|key,path|
      if FileTest.directory?(path)
        Find.find(path).each{|file|
          if /\/fv\// =~ file && /.*\.v$/ =~ file
            base_path = File.basename(file)
            # Copy File to save-dir
            FileUtils.cp("#{file}","#{dir}/#{base_path}")
          end
        }
      else
        printf("@E:not directory (%s)\n",path)
        exit
      end
    }
  end
end

if __FILE__ == $0
  collect = CollectHardMacroLibrary.new
  collect.main
end


