module Format2mp3                
  FileNotExistException = Class.new(RuntimeError)
  CommandNotPassedException = Class.new(RuntimeError)
    
  autoload :Wma, 'format2mp3/wma'
  
  class Base              
    attr_accessor :file, :output_dir
    
    def initialize(file, output=nil)
      @file = file
      @output_dir = output || File.path(file)
    end
            
    def file_exist?
      File.exist? @file
    end
    
    def convert(&command)                                
      raise FileNotExistException unless file_exist?      
      raise CommandNotPassedException unless block_given?
      yield
    end
    
    def output_system
      File.expand_path(File.join(@output_dir, File.basename(@file, File.extname(@file))))
    end
    
    # This is a model for commands to converto files
    def command_line
      "ffmpeg -i #{File.path(@file)} -acodec libmp3lame -ab 64k -ac 2 -ar 44100 -f mp3 -y #{output_system}.mp3"      
    end
  end  
end