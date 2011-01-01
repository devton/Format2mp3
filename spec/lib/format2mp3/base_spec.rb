require 'spec_helper'

describe Format2mp3::Base do
  context "when have a some file" do
    let(:wma_file) { File.join(TEST_FILES_PATH,'wma.wma') }
    let(:raise_file) { Format2mp3::Base.new("lorem/ipsum") }
    subject do
      Format2mp3::Base.new(wma_file)
    end
    
    context "#only_file_name" do
      it "should return the file name without ext." do
        subject.only_file_name.should == 'wma'
      end
    end
    
    context "#extname" do
      it "should return the file ext." do
        subject.extname.should == '.wma'
      end
    end
    
    context "#has_output?" do
      let(:has_output) {
        Format2mp3::Base.new(wma_file, File.join(TEST_FILES_PATH, 'output'))
      }
      
      it "should return true when convert the file" do
        has_output.to_mp3
        has_output.has_output?.should be_true
      end
      
      it "should return false when not convert the file" do
        has_output.has_output?.should be_false
      end
    end
    
    context "#to_mp3" do
      context "raise a ConversionException when" do
        it "not valid command" do
          lambda { 
            subject.stub!(:command_line).and_return("invalid command")
            subject.to_mp3
          }.should raise_exception(Format2mp3::ConversionException)
        end
        
        it "the output file don't exist" do
          lambda { 
            subject.stub!(:has_output?).and_return(false)
            subject.to_mp3
          }.should raise_exception(Format2mp3::ConversionException)          
          File.delete(subject.output_file) 
        end
      end
    end
    
    context "#output_file" do
      it "should return the path of the output mp3 file" do
        subject.output_file.should == 
          File.join(File.dirname(subject.file), "#{File.basename(subject.file, File.extname(subject.file))}.mp3")
      end
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