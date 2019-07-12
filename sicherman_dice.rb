require_relative 'counter'

# c = Counter.new([1, 2, 2, 3, 3, 4], [1, 3, 4, 5, 6, 8], [1, 2, 3, 4, 5, 6])
c = Counter.new([1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6])
totals = Hash.new(0)

puts '-' * 100

c.each do
	printf("%3d: %s\n", c.sum, c.inspect)
	totals[c.sum] += 1
end

puts totals.map { |k, v| sprintf("%2d: %d\n", k, v) }

# totals.each do |k, v|

# end
