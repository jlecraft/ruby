statNames = [:strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma]

statMods = {
	3 => -4,
	4 => -3,
	5 => -3,
	6 => -2,
	7 => -2,
	8 => -1,
	9 => -1,
	10 => 0,
	11 => 0,
	12 => 1,
	13 => 1,
	14 => 2,
	15 => 2,
	16 => 3,
	17 => 3,
	18 => 4,
}

d4  = [*(1..4)]
d6  = [*(1..6)]
d8  = [*(1..8)]
d10 = [*(1..10)]

totalBonus = 0

statNames.each do |stat|
	roll = d4.sample + d6.sample + d8.sample
	# roll = 2.times.inject(0) { |total, n| total += d6.sample }
	modifier = statMods[roll]

	if (modifier < 0) then
		totalBonus -= modifier
	end

	printf("%s\t%2d\t%3d\n", stat.slice(0, 3).upcase, roll, modifier)
end

puts "#{totalBonus} bonus stats"