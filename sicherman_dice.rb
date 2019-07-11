require_relative 'counter'

c = Counter.new([1, 2, 2, 3, 3, 4], [1, 3, 4, 5, 6, 8])

puts '-' * 100

c.each do
	printf("%3d: %s\n", c.sum, c.inspect)
end