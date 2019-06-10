class Counter
	def initialize(arg, options = {})
		if (arg =~ /(?:(\d+) d)? (\d+) \s* (?: \+ \s* (\d+))?/x)
			@count = ($1 || 1).to_i
			@max = $2.to_i
			@bonus = ($3 || 0).to_i
		end

		@digits = Array.new(@count, 1) 
	end
	
	def reset
		@digits.map! { 1 }
		self
	end

	def next!
		@digits.each_with_index do |v,i|
			if (v == @max)
				@digits[i] = 1
			else
				@digits[i] += 1
				break
			end
		end
		self
	end
	
	def zero?
		@digits.all? { |v| v == 1 }
	end
	
	def max?
		@digits.all? { |v| v == @max }
	end
	
	def each
		yield(@digits)
		yield(@digits) until (next!.zero?)
	end
	
	def inspect
		@digits
	end
end

c = Counter.new("2d20") #, drop_lowest: 1)

c.each { |a| p a }

