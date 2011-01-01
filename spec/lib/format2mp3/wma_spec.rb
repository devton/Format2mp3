require 'spec_helper'

describe Format2mp3::Wma do  
  context "when receive a .wma file" do
    let(:wma_file) { File.join(TEST_FILES_PATH,'wma.wma') }    
    subject do
      Format2mp3::Wma.new(wma_file, File.join(TEST_FILES_PATH, 'output'))
    end    
    
    it "should be convert to mp3 file" do
      subject.to_mp3.should be_true                                
    end
    
    it "should see the mp3 file in output dir" do
      subject.to_mp3
      File.exist?(subject.output_file).should be_true
    end
  end
end