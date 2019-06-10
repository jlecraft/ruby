module Speed
	SLOWEST = 0
	SLOW = 100
	MEDIUM = 200
	FAST = 300
	FASTEST = 400
end

class CombatUnit
	attr_accessor :playerControlled, :speed, :name, :tieBreakerSpeed, :attack, :health

	def initialize(hp, defense, atk, spd, name = "unknown", playerControlled = false)
		@speed = spd

		@maxHealth = hp
		@health = @maxHealth

		@defense = defense
		@attack = atk
		@name = name
		@playerControlled = (playerControlled ? 1 : 0)

		@tieBreakerSpeed = 0
	end

	def baseSpeed
		@speed
	end

	def speed
		@speed + (@playerControlled ? 50 : 0) + @tieBreakerSpeed
	end

	def alive?
		@health > 0
	end

	def defend(unit)
		damage = unit.attack
		@health -= damage
		alive?
	end

	def inspect
		[@name, speed, playerControlled]
		# [@name, @maxHealth, @defense, @attack, speed]
	end
end

# --------------------------------------------------------------------------------------------------------
def pickRandomTarget(attacker, allTargets)
	# puts "pickRandomTarget: #{attacker.inspect}"
	# p allTargets

	defenders = allTargets.map { |unit|
		if (attacker.playerControlled != unit.playerControlled) and (unit.alive?) then
			unit
		end
	}.compact

	defenders.empty? ? nil : defenders.sample
end

playerGroup = [
	CombatUnit.new(100, 0.25, 55, Speed::MEDIUM, "Thrall", true),
	CombatUnit.new(100, 0.25, 55, Speed::MEDIUM, "Jaina", true),
	CombatUnit.new(100, 0.25, 40, Speed::FAST, "Ironfur Bear", true)
]

monsterGroup = [
	CombatUnit.new(100, 0.25, 55, Speed::SLOW, "Ogre"),
	CombatUnit.new(100, 0.25, 30, Speed::MEDIUM, "Tidefin Breaker"),
	CombatUnit.new(100, 0.25, 30, Speed::MEDIUM, "Tidefin Slicer")
]

allUnits = playerGroup + monsterGroup
tieBreakers = [*(1..allUnits.size)].shuffle
turnOrder = allUnits.map { |unit| unit.tieBreakerSpeed = tieBreakers.pop; unit }
turnOrder.sort! { |a, b| a.speed <=> b.speed }.reverse!

10.times do |round|
	turnOrder.each do |unit|
		next unless unit.alive?
		
		t = pickRandomTarget(unit, allUnits)

		if (t.nil?) then
			break
		end

		death = t.defend(unit)
		# printf("%2d %s -> %s (%d)\n", unit.speed, unit.name, (t.nil? ? "?" : t.name), t.health)
		printf("%s -> %s (%d)\n", unit.name, (t.nil? ? "?" : t.name), t.health)
		puts "  #{t.name} died." unless t.alive?
	end
end

puts "Players:"
playerGroup.each do |unit|
	printf("%6d %s\n", unit.health, unit.name)
end

puts "Enemies:"
monsterGroup.each do |unit|
	printf("%6d %s\n", unit.health, unit.name)
end


# use shuffle for random selection
# remove unit from list when it dies (log event)


