require_relative "spec_helper"

describe "Sort jobs" do

  before do
    @jobs = Hash.new({})
  end
 
  it "returns an empty sequence" do
    JobSorter::sort(@jobs).should be_empty
  end

  it "returns a single job without dependency" do 
  	single_job_hash = @jobs.merge "a" => ""
 	JobSorter::sort(single_job_hash).should == ["a"]
 end

 it "returns multiple jobs without dependencies" do
 	multiple_jobs_hash = @jobs.merge "a" => "", "b" => "", "c" => ""
 	JobSorter::sort(multiple_jobs_hash).should == ["a", "b", "c"]
 end

  it "returns multiple jobs with one dependency found" do
 	multiple_jobs_hash = @jobs.merge "a" => "", "b" => "c", "c" => ""
 	JobSorter::sort(multiple_jobs_hash).should == ["a", "c", "b"]
 end

end