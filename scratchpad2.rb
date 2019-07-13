# statList = [*(1..20)].map { |n| n < 10 ? "0" + n.to_s : n.to_s }

# p statList

# alphaList = [*('A'..'Z')].map(&:to_sym)

# p alphaList

# p alphaList.zip(alphaList)

# bigList = alphaList.repeated_combination(2).map { |e| e.join("") }
myList = [*('A'..'Z')].map(&:to_sym)
myList << myList.repeated_permutation(2).map { |e| e.join.to_sym }.sort
myList.flatten!

p myList
puts "#{myList.size} elements"