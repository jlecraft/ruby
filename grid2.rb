class Grid
	include Enumerable
	
	attr_accessor(:data)
	
	def initialize(width, height, range = 20)
		@data = Array.new(height) { Array.new(width) { rand(range) + 1 } }
	end
	
	def print
		@data.each do |row|
			row.each do |cell|
				(cell ? printf("%4d", cell) : printf("%4s", '--'))
			end
			puts
		end
	end
	
	def delete(x, y)
		result = @data[y][x]
		@data[y][x] = nil
		
		return result
	end

	def each
		@data.each_with_index do |row, y|
			row.each_with_index do |value, x|
				yield [ value, x, y ]
			end
		end
	end
end

g = Grid.new(4, 6, 10)
g.print
p g.delete(2, 0)
g.print


# g.each {|v,x,y| print x, ",", y, "=", v, "\n" }
g.find_all {|v,x,y| (puts "[#{x},#{y}]" or true) if (v and (v > 8)) }

