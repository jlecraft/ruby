ITERATIONS = 100_000
ATTEMPTS = 5
DEBUG = false

chance = 0.0

100.times do |t|

	chance = t * 0.01
	critTotal = 0

	(1..ITERATIONS).each do |n|

		printf("%-4d: ", n) if DEBUG

		if (rand < chance) or (n % ATTEMPTS == 0) then
			puts "crit!" if DEBUG
			critTotal += 1
		else
			puts "hit" if DEBUG
		end
	end

	x = critTotal.fdiv(ITERATIONS)
	printf("%0.4f	%0.4f	%0.4f\n", chance, x, x - chance)
end