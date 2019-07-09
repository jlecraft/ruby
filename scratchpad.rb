outputFile = File.new('scratchpad.out', 'w+')

dieSides = 6
die = [*(1..6)]
total = 0

die.repeated_permutation(dieSides).each do |perm|
	outputFile.puts perm.join(" ")
	total += 1
end

puts "#{total} total"

total = 0
die.repeated_combination(dieSides).each do |perm|
	outputFile.puts perm.join(" ")
	total += 1
end

puts "#{total} total"

outputFile.close

###############################################################################
# ITERATIONS = 100_000_000

# total = 0
# ITERATIONS.times do
# 	if (rand < 0.1) then
# 		total += 1
# 	end
# end

# p total.fdiv(ITERATIONS)



###############################################################################
# fileName = 'C:\%s\%s\%s'

# fileName = fileName % %w(Users Projects jlecraft)

# # puts fileName

# fileNameCopy = fileName

# puts "fileName = #{fileName}"
# puts "fileNameCopy = #{fileNameCopy}"

# fileName.capitalize!

# puts "-" * 80
# puts "fileName = #{fileName}"
# puts "fileNameCopy = #{fileNameCopy}"

# puts "-" * 80
# puts

# if fileName =~ /ect/i then
# 	puts "found @#{}"
# end

# puts fileName =~ /xyz/i
