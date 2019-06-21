start = 1
counter = 0
maxCounter = 3

53.times do |n|
	if (counter >= maxCounter) then
		counter = 0
		start = start + 1
		maxCounter = maxCounter + 1
	end

	counter = counter + 1
	p start
end