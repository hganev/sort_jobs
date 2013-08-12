module JobSorter
	class << self
		def sort jobs
			raise "Jobs should not be nil" if jobs.nil?
			sorted_jobs = jobs.keys

			dependency_hash = dependencies(jobs)
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
					key_index = reordered_jobs.index(job_letter)
					value_index = reordered_jobs.index(dependencies[job_letter])

					next if key_index > value_index

					reordered_jobs[key_index,key_index] = dependencies.assoc(job_letter).reverse	
					reordered_jobs.uniq!
				end
			end
			reordered_jobs
		end
	end
end