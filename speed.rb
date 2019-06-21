class Character
	attr_reader :name, :speed, :turnBar

	def initialize(name, speed)
		@name = name
		@speed = speed
		@turnBar = 0
	end

	def increaseTurn
		@turnBar += @speed
	end

	def takeTurn?
		@turnBar >= 100
	end

	def takeTurn
		@turnBar -= 100
	end

	def inspect
		"#{@name}\n speed: #{@speed}\n turn: #{@turnBar}"
	end
end

characterList = [Character.new(:crafty, 45), Character.new(:joe, 38), Character.new(:tubby, 29)]

turnsTaken = Hash.new(0)

2420.times do
	# characterList.each do |ch|
	# 	p ch
	# end

	characterList.each do |ch|
		ch.increaseTurn
	end

	characterList.sort { |a, b| a.turnBar <=> b.turnBar }

	characterList.each do |ch|
		if ch.takeTurn? then
			# puts "#{ch.name} taking a turn"
			turnsTaken[ch.name] += 1
			ch.takeTurn
		end
	end
end

turnsTaken.each do |k, v|
	puts "#{k}, #{v}"
end
