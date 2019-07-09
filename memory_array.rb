class MemoryArray < Array
	def initialize(*args)
		super(*args)
		@currentIndex = 0
	end

	def value
		self[@currentIndex]
	end

	def next
		lastValue = value

		if ((@currentIndex + 1) < size) then
			@currentIndex += 1
		else
			@currentIndex = 0
		end

		lastValue
	end

	def inspect
		self.each_with_index.map { |e, i| (i == @currentIndex ? " (#{e})" : sprintf("%4d", e))}.join(" ")
	end
end

m = MemoryArray.new([*(1..8)])


15.times do |n|
	p m.next
end

