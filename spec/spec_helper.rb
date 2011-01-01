$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
TEST_FILES_PATH = File.expand_path(File.join(File.dirname(__FILE__),'files'))

require 'bundler'
Bundler.require

require 'format2mp3'

# optionally add autorun support
require 'rspec/autorun'

Rspec.configure do |c|
  c.mock_with :rspec  
  
  c.after(:each) do
    Dir.glob(File.join(TEST_FILES_PATH, 'output', '*')).each do |file|
      File.delete(file) 
    end
  end  
end


