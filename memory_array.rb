class MemoryArray < Array
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
		@currentIndex == (size - 1)
	end

	def next!
		if (@currentIndex < (size - 1)) then
			@currentIndex += 1
		else
			@currentIndex = 0
		end

		self
	end

	def inspect
		self.each_with_index.map { |e, i| (i == @currentIndex ? "(#{e})" : "#{e}")}.join(", ")
	end
end

# m1 = MemoryArray.new([*(1..6)])
# m2 = MemoryArray.new([*(1..4)])

# diceList = [m1, m2]

