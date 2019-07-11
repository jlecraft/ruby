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

d100 = [*(1..100)]
d4 = d100.slice(0, 4)
d6 = d100.slice(0, 6)
d8 = d100.slice(0, 8)
d10 = d100.slice(0, 10)
d12 = d100.slice(0, 12)
d20 = d100.slice(0, 20)

special1 = [1, 2, 2, 3, 3, 4] # 21
special2 = [1, 3, 4, 5, 6, 8]


# c = Counter.new(d4, d4)
c = Counter.new(special1, special2)

totals = Hash.new(0)
outputFile = File.new("counter.out", "w+")

c.each do
	printf("%3d: %s\n", c.sum, c.inspect)
end
