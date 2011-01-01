require 'spec_helper'

describe Format2mp3::Base do
  context "when have a some file" do
    let(:wma_file) { File.join(TEST_FILES_PATH,'wma.wma') }
    let(:raise_file) { Format2mp3::Base.new("lorem/ipsum") }
    subject do
      Format2mp3::Base.new(wma_file)
    end
    
    context "#output_system" do
      context "when pass the output file dir" do
        let(:with_output){Format2mp3::Base.new(wma_file, File.join(TEST_FILES_PATH,'output'))}
        
        it "shoud be return the output dir with archive name" do
          with_output.output_system.should =~ /(.*)\/files\/output\/#{File.basename(wma_file, ".wma")}/                                                
        end
      end
    end
        
    context "#convert" do
      context "when file don't exist" do
        it "should raise a FileNotExistException" do
          lambda { raise_file.convert }.should raise_exception(Format2mp3::FileNotExistException)
        end        
      end        
      
      context "when command not passed" do
        it "should raise a CommandNotPassedException" do
          lambda { subject.convert }.should raise_exception(Format2mp3::CommandNotPassedException)
        end        
      end
    end                   
    
    context "#file_exist?" do      
      it "should be true if the file exist" do
        subject.file_exist?.should be_true
      end
      
      it "should be false if the file don't exist" do
        raise_file.file_exist?.should be_false
      end
    end    
  end  
end