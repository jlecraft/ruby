class Counter
	# Expect a variable number of arrays
	def initialize(*args)
		@dice = args.dup
		@indices = Array.new(@dice.size, 0)
	end
	
	def reset
		@indices.map! { 0 }
		self
	end

	def next!
		@indices.each_with_index do |v, i|
			if (v >= (@dice[i].size - 1))
				@indices[i] = 0
			else
				@indices[i] += 1
				break
			end
		end
		self
	end
	
	def zero?
		@indices.all? { |v| v == 0 }
	end
	
	# def each
	# 	yield(@indices)
	# 	yield(@indices) until (next!.zero?)
	# end

	def each
		yield(@indices.each_with_index.map { |idx, i| @dice[i][idx] })
		next!

		while (not zero?) do
			yield(@indices.each_with_index.map { |idx, i| @dice[i][idx] })
			next!
		end
	end
	
	def inspect
		@indices
	end
end

d4 = [*(1..4)]
d6 = [*(1..6)]
d8 = [*(1..8)]
d10 = [*(1..10)]
d12 = [*(1..12)]

special1 = [1, 2, 3, 4, 5, 5] # 21
special2 = [1, 2, 2, 2, 3, 7]


c = Counter.new(d6, d6, d6, d6, d6, d6)

totals = Hash.new(0)

outputFile = File.new("counter.out", "w+")

c.each do |dieSet|
	dieSum = dieSet.inject(:+)
	totals[dieSum] += 1
	outputFile.printf("%s\n", dieSet.sort.join("\t"))
end

tmp = totals.map do |k, v|
	"#{k} = #{v}"
end

puts tmp