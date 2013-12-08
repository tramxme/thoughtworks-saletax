require "spec_helper"

describe Exempt do 
  before (:each) do
    @item = Exempt.new
  end

  it "should read the text file successfully" do

  end

  it "should identify 'book' as an exempt item" do 
  end

  it "should identify 'pills' as an exempt item" do
  end

  it "should return the untaxed prize for regular exempt item" do
    @item.exempt(15).should eq 15
  end

  it "should return the taxed prize for imported exempt item" do
    new_prize = @item.exempt(10) + @item.regular_tax(10)
    new_prize.should eq 10.50
  end
end

describe Nonexempt do
  before (:each) do
    @item = Nonexempt.new
  end

  it "should return the new prize with 10% tax for non-imported item" do
  end


  it "should identify music CD as an non-exempt item" do 
  end


  it "should return the new prize with 10% tax and an additional 5% for imported item" do
  end


end



