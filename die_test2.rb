require_relative 'counter'

d20 = [*(1..20)]
d12 = d20.first(12)
d10 = d20.first(10)
d8 = d20.first(8)
d6 = d20.first(6)
d4 = d20.first(4)

dieSet = Counter.new(d6, d6, d6)

totals = Hash.new(0)
total = 0

dieSet.each do
	totals[dieSet.sum] += 1
	total += 1
end

puts totals.map { |k, v| sprintf("%2d\t%4d\t%.2f%%\n", k, v, v.fdiv(total) * 100) }
puts "#{total} total"

puts '-' * 100

6.times do
	roll = dieSet.sample.sort.last(3)
	sum = roll.inject(:+)
	printf("%2d\t%s\n", sum, roll.join("\t"))
end