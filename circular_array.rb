class CyclicReadArray < Array
	def initialize(*args)
		super(*args)
		@currentIndex = 0
	end

	def reset
		@currentIndex = 0
	end

	def value
		self[@currentIndex]
	end

	def first?
		@currentIndex == 0
	end

	def last?
		(@currentIndex + 1) == size
	end

	def next!
		if ((@currentIndex + 1) < size) then
			@currentIndex += 1
		else
			@currentIndex = 0
		end

		self
	end

	def inspect
		value
	end
end


