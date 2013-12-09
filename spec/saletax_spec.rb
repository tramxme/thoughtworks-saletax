require "spec_helper"

describe Exempt do

  it "should return the untaxed prize for regular exempt item" do
    item = Exempt.new
    item.exempt(10).should eq 10
  end

  it "should return the new prize with 5% tax for imported exempt item" do
    item = Exempt.new
    item.exempt(10,true).should eq 10.5
  end

end



describe Nonexempt do

  it "should return the new prize with 10% tax for non-imported non-exempted item" do
    item = Nonexempt.new
    item.non_exempt(14.99).should eq 16.49
  end

  it "should return the new prize with 10% tax and an additional 5% for imported non-exempted item" do
    item = Nonexempt.new
    item.non_exempt(27.99, true).should eq 32.19
  end

end



describe print_out do 
  
  it "should read the file successfully" do
    print_out("input1.txt").should_not raise_error
  end

end






