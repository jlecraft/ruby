require_relative 'memory_array'

class Counter
	def initialize(*args)
		@dice = []
		args.each do |ary|
			@dice << MemoryArray.new(ary)
		end
	end
	
	def reset
		@dice.each { |d| d.reset }
		self
	end

	def next!
		@dice.each do |die|
			unless (die.next!.first?) then
				break
			end
		end
		self
	end
	
	def first?
		@dice.all? { |die| die.first? }
	end

	def sum
		@dice.inject(0) { |total, die| total + die.value }
	end
	
	def each
		yield(@dice)
		yield(@dice) until (next!.first?)
	end

	def inspect
		@dice.map { |d| d.value }
	end
end

