module JobSorter
	class << self
		def sort jobs
			raise "Jobs should not be nil" if jobs.nil?
			sorted_jobs = jobs.keys

			dependency_hash = dependencies(jobs)
			p dependency_hash
			return sorted_jobs if dependency_hash.empty?
			reorder(sorted_jobs, dependency_hash)
		end

		def dependencies hash
			dependency_hash = hash.select { |key, value| value[0] }
		end

		def reorder(jobs, dependencies)
			reordered_jobs = jobs.dup
			jobs.each_with_index do |job_letter, index|
				if dependencies.keys.include?(job_letter)
					reordered_jobs[index,index] = dependencies.assoc(job_letter).reverse			
				end
			end
			reordered_jobs.uniq	
		end
	end
end