# statList = %i(1 2 3 4 5 6 7 8 )
coinFlip = [:heads, :tails]
smallList = [:A, :B, :C]
statList = [*(1..20)].map { |n| n < 10 ? "0" + n.to_s : n.to_s }

puts "Permutation: #{smallList}"
smallList.permutation.each do |x|
	puts x.join(', ')
end

puts "Combination(2): #{smallList}"
smallList.combination(2).each do |x|
	puts x.join(', ')
end

puts "Repeated Combinations(2): #{smallList}"
smallList.repeated_combination(2).each do |x|
	puts x.join(', ')
end

puts "Repeated Permutation(2): #{smallList}"
smallList.repeated_permutation(2).each do |x|
	puts x.join(', ')
end

# coinFlip.permutation.each do |ele|
# 	puts ele.join(', ')
# end

# statList.combination(2).each do |ele|
# 	puts ele.join(', ')
# end



# # myList.permutation(2).each do |pair|
# statList.each { |stat| puts stat }

# total = statList.size
# statList.repeated_combination(3).each do |pair|
# 	unless (pair.first == pair.last) then
# 		puts pair.join(", ")
# 		total += 1
# 	end
# end

# puts "#{total} combinations"