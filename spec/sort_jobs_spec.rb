require_relative "spec_helper"

describe "Sort jobs" do

  before do
    @jobs = Hash.new({})
  end
 
  it "returns an empty sequence" do
    JobSorter::sort(@jobs).should be_empty
  end
 
end