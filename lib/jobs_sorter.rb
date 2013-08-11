module JobSorter
	class << self
		def sort jobs
			return [] if jobs.nil? || jobs.empty?
			dependency_hash = dependencies(jobs)
			return jobs.keys if dependency_hash.empty?
		end

		def dependencies hash
			dependency_hash = hash.map { |key, value| value[0] }
			dependency_hash.compact
		end
	end
end