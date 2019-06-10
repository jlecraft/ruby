# unshift adds to front, shift takes from the front
# use push or << to add to end

class Card
	attr_reader :type, :value

	def initialize(type, value)
		@type = type
		@value = value.to_i
	end

	def treasure?
		@type == :treasure
	end

	def encounter?
		@type == :encounter
	end

	def printedType
		(@type == :treasure ? "T" : "E")
	end

	def >(other)
		if (other.is_a? Integer) then
			other > @value
		elsif (other.is_a? Card) then
			other.value > @value
		end
	end

	def <(other)
		if (other.is_a? Integer) then
			other < @value
		elsif (other.is_a? Card) then
			other.value < @value
		end
	end

	def +(other)
		if (other.is_a? Integer) then
			@value + other
		else
			@value + other.value
		end
	end

	def -(other)
		if (other.is_a? Integer) then
			@value - other
		else
			@value - other.value
		end
	end

	def to_i
		@value
	end

	def coerce(other)
		[other.to_i, @value]
	end

	def inspect
		"#{printedType}:#{@value}"
	end
end


class Room
	def initialize
		@attacks = []
		@encounters = []
		@treasures = []
	end

	def clear
		@attacks.clear
		@encounters.clear
		@treasures.clear
	end

	def treasureTotal
		@treasures.inject(0, :+)
	end

	def attackTotal
		@attacks.inject(0, :+)
	end

	def score
		treasureTotal + @encounters.size + @attacks.size
	end

	def lastEncounter
		@encounters.last
	end

	def lastTreasure
		@treasures.last
	end

	def firstTreasure
		@treasures.first
	end

	def lastAttack
		@attacks.last
	end

	def canAdd(card, isAttack = false)
		# Room is empty, so the only invalid move is an attack
		if empty? then
			not isAttack

		# This is an attack, so it's valid as long as we have at least 1 encounter
		elsif (isAttack && card.treasure?) then
			not @encounters.empty?

		# Treasures must be lower than any treasures and encounters
		elsif (card.treasure?) then
			card.value < (@encounters | @treasures | [card]).reduce(card.value) { |low, c| c.value < low ? c.value : low }

		# Encounters must be higher than any treasures and encounters
		elsif (card.encounter? and @attacks.empty?) then
			card.value < (@encounters | @treasures | [card]).reduce(card.value) { |high, c| c.value > high ? c.value : high }

		end
	end

	def empty?
		@encounters.empty? and @treasures.empty?
	end

	def won?
		attackTotal > (@encounters.last)
	end

	def addTreasure(card)
		@treasures << card
	end

	def addEncounter(card)
		@encounters << card
	end

	def addAttack(card)
		@attacks << card
		won?
	end

	def addCard(card, isAttack = false)
		# puts (isAttack ? "Attacking" : "Adding") + " #{card.inspect}"

		if (isAttack and card.treasure?) then
			addAttack(card)
		elsif (card.treasure?) then
			addTreasure(card)
			nil
		elsif (card.encounter?) then
			addEncounter(card)
			nil
		end
	end

	def inspect
		(@encounters.map { |c| "(#{c.inspect})" } + @treasures.map { |c| "(#{c.inspect})"}).join(", ")
	end

	def deepInspect
		cards = @treasures.reverse.map { |c| c.inspect } + @encounters.map { |c| c.inspect }

		puts cards.join(", ")

		if (not @attacks.empty?) then
			puts "--> #{attackTotal}: " + @attacks.map { |c| c.inspect }.join(", ")
		end

		puts "Score: #{score}"
	end
end


class Game
	ACTION_DEFAULT = 0
	ACTION_ADD_TREASURE = 1
	ACTION_ATTACK = 2
	ACTION_ADD_ENCOUNTER = 3
	ACTION_DISCARD = 4
	ACTION_WIN_ROOM = 5

	attr_accessor :debug

	def initialize(deck)
		@deck = deck
		@rooms = [Room.new, Room.new, Room.new, Room.new]
		@debug = false
	end

	def clear(shuffleDeck = false)
		deck.shuffle if shuffleDeck
		@rooms.each { |r| r.clear }
	end

	def actionToString(action)
		case action
		when Game::ACTION_DEFAULT
			'_'
		when Game::ACTION_ADD_TREASURE
			'+'
		when Game::ACTION_ATTACK
			'>'
		when Game::ACTION_ADD_ENCOUNTER
			'+'
		when Game::ACTION_DISCARD
			'-'
		when Game::ACTION_WIN_ROOM
			'*'
		else
			'?'
		end
	end

	def printRooms
		@rooms.each do |r|
			# printf("%02s|%02s (%2d)   ", (r.lastTreasure.nil? ? '--' : r.lastTreasure), (r.lastEncounter.nil? ? '--' : r.lastEncounter), r.treasureTotal)
			printf("%02s|%02s   ", (r.treasureTotal < 1 ? '--' : r.treasureTotal), (r.lastEncounter.nil? ? '--' : r.lastEncounter - r.attackTotal))
		end
		puts
	end

# 	if SRAND_OVERRIDE then
# 		Random::srand SRAND_OVERRIDE
# 	else
# 		lastSeed = srand
# 	end

	def play(seed = nil)
		score = 0
		discards = 0

		if (seed) then
			Random::srand seed
		else
			seed = srand
		end

		@deck.drop(@rooms.size).each_with_index do |card, count|
			action = (card.treasure? ? Game::ACTION_ADD_TREASURE : Game::ACTION_ADD_ENCOUNTER)

			choices = @rooms.select { |r| r.canAdd(card) }

			printf("%2d\t", count) if @debug

			if (choices.empty? and card.treasure?) then
				action = Game::ACTION_ATTACK
				choices = @rooms.select { |r| r.canAdd(card, true) }
			end

			if (choices.empty?) then
				action = Game::ACTION_DISCARD
				discards += 1
		 	else
				activeRoom = choices.sample

				if (activeRoom.addCard(card, (action == Game::ACTION_ATTACK ? true : false))) then
					action = Game::ACTION_WIN_ROOM
					score += activeRoom.score

					print("#{actionToString(action)}#{card.inspect}  " + (card.value >= 10 ? " " : "  ")) if @debug
					printRooms if @debug

					activeRoom.clear
				else
					# print "  #{card.value} -> #{activeRoom.lastEncounter - activeRoom.attackTotal}\n" if (action == Game::ACTION_ATTACK)
				end
			end

			unless action == Game::ACTION_WIN_ROOM
				print("#{actionToString(action)}#{card.inspect}  " + (card.value >= 10 ? " " : "  ")) if @debug
				printRooms if @debug
			end
		end

		[score, discards, srand]
	end
end

# ------------------------------------------------------------------------------------------
# Build our deck
# ------------------------------------------------------------------------------------------
deck = []

DATA.each do |line|
	cardAbbreviation, quantity = line.strip.chomp.split(/\t/)
	value, type = cardAbbreviation.match(/(\d+)([T|E])/).captures

	quantity.to_i.times { |n| deck << Card.new((type == "E" ? :encounter : :treasure), value.to_i) }
end

deck.shuffle!(random: Random.new(95))
puts deck.map { |c| c.inspect }.join(", ")

# ------------------------------------------------------------------------------------------
# Create our game
# ------------------------------------------------------------------------------------------
game = Game.new(deck)
game.debug = true

# ------------------------------------------------------------------------------------------
# Run through many games and keep track of the scores
# ------------------------------------------------------------------------------------------
mySeed = 46797507888481224114314441513752070244
ITERATIONS = 1_000

scores = Hash.new(0)
totalDiscards = 0
highScore = 0

(mySeed ? 1 : ITERATIONS).times do
	score, discards, seed = game.play(mySeed)

	if (score > highScore) then
		highScore = score
		printf("%4d: %d\n", score, seed)
	end

	# scores[s] += 1
	totalDiscards += discards
	game.clear
end

# scores.sort.each do |score, total|
# 	printf("%4d: %d\n", score, total)
# end

printf("Avg. discards %02f\n", totalDiscards.fdiv(ITERATIONS))

# rooms = [Room.new, Room.new, Room.new, Room.new]
# scores = Hash.new(0)
# highScore = 1
# score = 0
# lastSeed = -1
# action = '*'

# SRAND_OVERRIDE = 173935716264218684412318258514648708121
# ITERATIONS = 1_000_000

# ITERATIONS.times do
# 	if SRAND_OVERRIDE then
# 		Random::srand SRAND_OVERRIDE
# 	else
# 		lastSeed = srand
# 	end

# 	if (score == highScore) and not SRAND_OVERRIDE then
# 		puts lastSeed
# 	end

# 	roomsMade = rooms.size
# 	rooms.each { |r| r.clear }

# 	score = 0

# 	deck.each do |card|
# 		if (roomsMade > 0) then
# 			puts "Creating room: #{card.inspect}" if SRAND_OVERRIDE
# 			roomsMade -= 1
# 			next
# 		end

# 		action = '+'

# 		isAttack = false
# 		choices = rooms.select { |r| r.canAdd(card) }

# 		if (choices.empty? and card.treasure?) then
# 			isAttack = true
# 			choices = rooms.select { |r| r.canAdd(card, true) }
# 			action = '*'
# 		end

# 		if (choices.empty?) then
# 			score += 1
# 			action = '-'
# 		else
# 			activeRoom = choices.sample

# 			if (activeRoom.addCard(card, isAttack)) then
# 				# puts "WIN!" if SRAND_OVERRIDE
# 				# activeRoom.deepInspect if SRAND_OVERRIDE

# 				score += activeRoom.score
# 				# printf("SCORE: %3d (+%d)\n", score, activeRoom.score)
# 				activeRoom.clear
# 			else
# 				# activeRoom.deepInspect if SRAND_OVERRIDE
# 			end
# 		end

# 		printf("%3d %s%s%s    ", score, action, card.inspect, (card.value > 9) ? "" : ' ') if SRAND_OVERRIDE

# 		rooms.each do |r|
# 			printf("%02d|%02d (%2d)   ", (r.lastTreasure.nil? ? 0 : r.lastTreasure), (r.lastEncounter.nil? ? 0 : r.lastEncounter), r.treasureTotal) if SRAND_OVERRIDE
# 		end

# 		puts if SRAND_OVERRIDE
# 	end

# 	scores[score] += 1

# 	if (score > highScore) then
# 		highScore = score
# 		print "Score: #{score}, " unless SRAND_OVERRIDE
# 	end

# 	break if SRAND_OVERRIDE
# end

# scores.sort.each do |s, total|
# 	printf("%3d %d\n", s, total)
# end

# +T10  04|09 (11)    03|05 (7)     00|00 (0)     08|10 (30)
# 	  >> 04		                                >> 06
# -E7   04|09 (11)    03|05 (7)     00|00 (0)     08|10 (30)
# -E6   04|09 (11)    03|05 (7)     00|00 (0)     08|10 (30)
# *E6   04|09 (11)    03|05 (7)     00|00 (0)     08|10 (30)

# 2T	3
# 3T	4
# 4T	4
# 5T	5
# 6T	7
# 7T	6
# 8T	5
# 9T	3
# 5E	2
# 6E	2
# 7E	3
# 8E	3
# 9E	4
# 10E	4

__END__
2T	3
3T	4
4T	4
5T	5
6T	7
7T	6
8T	5
9T	3
7E	4
8E	5
9E	5
10E	4