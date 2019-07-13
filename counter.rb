require_relative 'circular_array'

class Counter
	def initialize(*args)
		@dice = args.map { |a| CyclicReadArray.new(a) }
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

	def sample
		@dice.map { |die| die.sample }
	end
	
	def each
		yield(@dice)
		yield(@dice) until (next!.first?)
	end

	def to_a
		@dice.map { |d| d.value }
	end

	def inspect
		to_a
	end
end

