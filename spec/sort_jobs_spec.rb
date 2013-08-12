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

	it "returns multiple jobs sequence without dependencies" do
		multiple_jobs_hash = @jobs.merge "a" => "", "b" => "", "c" => ""
		JobSorter::sort(multiple_jobs_hash).should == ["a", "b", "c"]
	end

	it "returns ordered multiple jobs sequence with one dependency" do
		multiple_jobs_hash = @jobs.merge "a" => "", "b" => "c", "c" => ""
		JobSorter::sort(multiple_jobs_hash).should == ["a", "c", "b"]
	end

	it "returns ordered multiple jobs sequence with multiple dependencies" do
		multiple_jobs_hash = @jobs.merge "a" => "", "b" => "c", "c" => "f", "d" => "a", "e" => "b", "f" => ""
		JobSorter::sort(multiple_jobs_hash).should == ["a", "f", "c", "b", "d", "e"]
	end

	it "throws error because jobs can't depend on themselves" do
		self_depend_jobs_hash = @jobs.merge "a" => "", "b" => "", "c" => "c"
		expect { JobSorter::dependencies(self_depend_jobs_hash) }.to raise_error
	end

end