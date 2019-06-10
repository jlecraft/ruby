class Grid
	def initialize(width, height)
		@width, @height = width, height
		
		# [ [ 0, 1, 2, ... ]
		#   [ 0, 1, 2, ... ]
		#   ...
		# ]
		
		@grid = Array.new(height) { Array.new(width, 0) }
	end
	
	def randomize(&block)
		@grid.each_with_index do |row, i|
			@grid[i] = row.collect { |element| block.call(element) }
		end
	end
	
	def print
		@grid.each do |row|
			row.each { |e| printf(" %2s ", e) }
			puts
		end
	end
	
	Directions = {
		:n => [0, -1],
		:e => [1, 0],
		:w => [-1, 0],
		:s => [0, 1],
		:nw => [-1, -1],
		:ne => [1, -1],
		:sw => [-1, 1],
		:se => [1, 1],
	}
	
	def value(x, y, direction = nil)
		x_offset, y_offset = Directions[direction]
		x += x_offset || 0
		y += y_offset || 0
	
		return if ((x < 0) or (x > @width) or (y < 0) or (y > @height))
		
		@grid[y][x]
	end
	
	def compare(x, y, comp_val, direction = nil)
		return (comp_val == value(x, y, direction))
	end
	
	def find_continuous
		@grid.each_with_index do |row, y|
			row.each_with_index do |cell, x|
				if (compare(x, y, cell, :e))
					puts "found"
				end
			end
		end
		
		# go from left to right and do valid comparisons
		# loc = x, y
		# loc.compare(-1)
	end
end

g = Grid.new(6, 8)
picks = Array[*('A'..'G')]
g.randomize { picks.sample }
g.print

# g.find_continuous
#   concept of an array and always using the last element
#   when do we need to backtrack?  :order_matters
#   should provide an enumerator?

# swap entries

# find vertical
# find horizontal
# find vert + horizontal
# find continuous with directions

# destroy tiles (and specify a gravity type, :up, :down, :left, :right, :none)
# should be able to specify a block for the fill routine, override on destroy tiles?
