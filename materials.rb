MaxGrade = 8
UpgradeCost = 3

(1..MaxGrade).each do |n|
	cost = UpgradeCost
	((n + 1)..MaxGrade).each do |y|
		# printf("material%d\t%d\tmaterial%d\n", n, cost, y)
		printf("%8d material%d = material%d\n", cost, n, y)
		cost *= UpgradeCost
	end
	puts
end