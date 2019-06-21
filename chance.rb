total = 0

1000000.times do |n|
	found = false
	if (rand < 0.5) then
		found = true
	end

	if (rand < 0.5) then
		found = true
	end

	total += 1 if found
end

p total