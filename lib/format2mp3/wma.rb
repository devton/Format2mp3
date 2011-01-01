module Format2mp3
  class Wma < Format2mp3::Base
    def to_mp3
      convert do
        system(command_line)
      end      
    end
  end
end