statList = %i(haste crit crit_dmg dodge a b c d e f g h i j k l m n o p)


# myList.permutation(2).each do |pair|
statList.each { |stat| puts stat }

total = statList.size
statList.repeated_combination(2).each do |pair|
	unless (pair.first == pair.last) then
		puts pair.join(", ")
		total += 1
	end
end

puts "#{total} combinations"