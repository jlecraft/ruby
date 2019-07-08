class Die
	
end

die1 = [1, 3, 4, 5, 6, 8]
die2 = [1, 2, 2, 3, 3, 4]

totals = Hash.new(0)
pairs = Array.new

die_set = Array.new << die1 << die2

die_set.each do |die|

end


# die1.each do |a|
# 	die2.each do |b|
# 		totals[(a + b)] += 1
# 		pairs << [a, b]
# 		# puts "#{a} #{b} (#{a + b})" + (a == b ? " (D)" : "")
# 	end
# end

# pairs.sort { |a, b| (a.first + a.last) <=> (b.first + b.last) }.each do |x|
# 	printf("%2d: %d, %d\n", x.inject(:+), x[0], x[1])
# end

# puts totals.map { |k, v| "#{k} (#{v})" }.join(", ")
