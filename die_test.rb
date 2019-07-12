require_relative 'counter'

d6 = [*(1..6)]

dieSet = Counter.new(d6, d6, d6, d6)

totals = Hash.new(0)

dieSet.each do |s|
	p dieSet.to_a.sort.slice(1, 3).inject(:+)
	# p s.sort
	# print " "
	# p s.sort.slice(1, 3)
	# sum = s.sort.slice(1, 3).inject(0) { |total, die| total + die.value }
	# totals[sum] += 1
end

puts totals.map { |k, v| sprintf("%2d: %4d\n", k, v) }