class Card
	attr_reader :suit, :value

	def initialize(arg)
		@suit, @value = *arg
	end

	def inspect
		"#{value}:#{suit}"
	end

end

p orderedDeck = [:H, :D, :C, :S].product([*(1..9), 0, :J, :Q, :K]).map { |p| Card.new(p) }

# Create N piles
# 1 2 3 4 5
# 4 2 5 1 3

STACK_ORDER = [4, 2, 5, 1, 3]

stacks = Array.new(STACK_ORDER.size) { [] }

deck = orderedDeck.dup

until deck.empty?
	stacks.each do |stack|
		stack << deck.slice!(0)
	end
end

p shuffledDeck = STACK_ORDER.map { |i| stacks[i - 1].compact }.flatten