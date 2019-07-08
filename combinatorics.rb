# statList = %i(1 2 3 4 5 6 7 8 )
statList = [*(1..20)].map { |n| n < 10 ? "0" + n.to_s : n.to_s }


# myList.permutation(2).each do |pair|
statList.each { |stat| puts stat }

total = statList.size
statList.repeated_combination(3).each do |pair|
	unless (pair.first == pair.last) then
		puts pair.join(", ")
		total += 1
	end
end

puts "#{total} combinations"