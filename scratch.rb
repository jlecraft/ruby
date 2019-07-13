require_relative 'counter'

d6 = [*(1..6)]
a = 3.times.map { d6.dup }

p a
d6[0] = 12
p a

# d100 = [*(1..100)]
# d4 = d100.slice(0, 4)
# d6 = d100.slice(0, 6)
# d8 = d100.slice(0, 8)
# d10 = d100.slice(0, 10)
# d12 = d100.slice(0, 12)
# d20 = d100.slice(0, 20)

# special1 = [1, 2, 2, 3, 3, 4] # 21
# special2 = [1, 3, 4, 5, 6, 8]

# # c = Counter.new(d4, d4)
# c = Counter.new(special1, special2)

# totals = Hash.new(0)
# outputFile = File.new("counter.out", "w+")

# c.each do
# 	printf("%3d: %s\n", c.sum, c.inspect)
# end


# # [1, 2, 3, 4, 5, 6].repeated_permutation(6) do |n|
# [1, 2, 3, 4, 5, 6].repeated_combination(6) do |n|
# 	puts n.sort.join("\t")
# end
# # DATA.each_line do |l|
# # 	puts l.chomp.split(/\t/).sort.join("\t")
# # end

# # __END__
# # 1	1	1	1
# # 1	1	1	2
# # 1	1	2	1
# # 1	1	2	2
# # 1	2	1	1
# # 1	2	1	2
# # 1	2	2	1
# # 1	2	2	2
# # 2	1	1	1
# # 2	1	1	2
# # 2	1	2	1
# # 2	1	2	2
# # 2	2	1	1
# # 2	2	1	2
# # 2	2	2	1
# # 2	2	2	2
