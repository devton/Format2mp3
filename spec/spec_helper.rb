$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'bundler'
Bundler.require

require 'format2mp3'

# optionally add autorun support
require 'rspec/autorun'

Rspec.configure do |c|
  c.mock_with :rspec
end


