ITERATIONS = 1_000_000
total = 0

ITERATIONS.times do |n|
	found = false
	if (rand < 0.5) then
		found = true
	end

	if (rand < 0.5) then
		found = true
	end

	total += 1 if found
end

puts "#{total.fdiv(ITERATIONS)}"