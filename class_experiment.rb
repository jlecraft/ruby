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

	def to_s
		(@type == :treasure ? 'T' : 'E')
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

	def to_i
		@value
	end

	def coerce(other)
		[other.to_i, @value]
	end

	def inspect
		"#{self.to_s}:#{@value}"
	end
end

class Room
	attr_reader :cards

	def initialize(cards = nil)
		@cards = [cards].compact

		# Totals
		@treasureTotal = 0
		@encounterTotal = 0
		@attackTotal = 0

		# Min/max values
		@minTreasure = 0
		@maxEncounter = 0
	end
r
	def treasureTotal
		@cards.select { |c| c.treasure? }.inject(0, :+)
	end

	def treasureTotal
		@cards.select { |c| c.treasure? }.inject(0, :+)
	end

	def canAdd(card)
		if (card.isTreasure?) then
			# Must be lower than lowest encounter and lowest treasure
			card.value < @minTreasure and card.value < @min
		else
		end
	end

	def inspect
		@cards.map { |c| c.inspect }.join(", ")
	end
end


deck = ((1..10).map { |n| [Card.new(:treasure, n), Card.new(:encounter, n)] } * 2).flatten

deck.shuffle!

p deck

deck.drop(4).each do |card|
	p Room.new(card).treasureTotal
end
