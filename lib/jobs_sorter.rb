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
			circular_dependency_check hash
			dependency_hash = hash.select do |key, value| 
				self_dependency_check(key, value)
				value[0] 
			end		
		end

		def self_dependency_check(key,value)
			raise "Jobs can't depend on themselves" if key == value
		end

		def circular_dependency_check dependencies
			dependencies.each_key { |key| build_graph(key, dependencies) }
		end

		def build_graph(start_point, hash)
			result = [start_point]
			value = hash[start_point]
			while start_point[0]
				value = hash[start_point]
				break if value.nil?
				raise "Jobs can't have circular dependencies" if result.include? value
				(result << value) if value[0]
				start_point = value
			end
			result
		end

		def reorder(jobs, dependencies)
			reordered_jobs = jobs.dup
			jobs.each_with_index do |job_letter, index|
				if dependencies.keys.include? job_letter
					key_index = reordered_jobs.index job_letter
					value_index = reordered_jobs.index dependencies[job_letter]

					next if key_index > value_index

					reordered_jobs[key_index,key_index] = dependencies.assoc(job_letter).reverse	
					reordered_jobs.uniq!
				end
			end


			reordered_jobs
		end

	end
end