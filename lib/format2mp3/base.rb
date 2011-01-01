module Format2mp3                
  FileNotExistException = Class.new(RuntimeError)
  CommandNotPassedException = Class.new(RuntimeError)
  ConversionException = Class.new(RuntimeError)
    
  autoload :Wma, 'format2mp3/wma'
  
  class Base              
    attr_accessor :file, :output_dir
    
    def initialize(file, output=nil)
      @file = file                           
      @output_dir = output || File.dirname(file)
    end
    
    def only_file_name
      File.basename(@file, extname)
    end
    
    def extname
      File.extname(@file)
    end
            
    def file_exist?
      File.exist? @file
    end
        
    def has_output?
      File.exist?(output_file)
    end
    
    def output_file
      output_system+'.mp3'
    end
    
    def output_system
      File.expand_path(File.join(@output_dir, only_file_name))
    end
    
    def to_mp3
      convert do                         
        if system(command_line) && has_output?
          true #for moment should return true :)
        else                                   
          raise ConversionException
        end
      end      
    end
    
    def convert(&command)                                
      raise FileNotExistException unless file_exist?      
      raise CommandNotPassedException unless block_given?
      yield
    end        
    
    # This is a model for commands to converto files
    def command_line
      "ffmpeg -i #{File.path(@file)} -acodec libmp3lame -ab 64k -ac 2 -ar 44100 -f mp3 -y #{output_system}.mp3"      
    end
  end  
end