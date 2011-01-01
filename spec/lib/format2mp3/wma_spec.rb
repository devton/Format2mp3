require 'spec_helper'

describe Format2mp3::Wma do  
  context "when receive a .wma file should be convert to .mp3 file" do
    let(:wma_file) { File.join(TEST_FILES_PATH,'wma.wma') }    
    subject do
      Format2mp3::Wma.new(wma_file, File.join(TEST_FILES_PATH, 'output'))
    end
    it "does something" do
      subject.to_mp3
    end
  end
end