class CombatEvent
	attr_reader :timer, :cooldown, :name

	def initialize(name, cooldown, timer, &block)
		@timer = timer
		@name = name
		@cooldown = cooldown
		@block = block
	end

	def ready?(t)
		# puts ":#{@name}, t = #{t}, @timer = #{@timer}"
		t >= @timer
	end

	def activate(*args)
		if @block then
			@block.call(*args)
		end
	end

	def advance
		@timer += @cooldown
	end

	def inspect
		[@name, @timer]
	end
end

class Player
	attr_accessor :crit, :haste, :fury

	def initialize(crit: 0.1, haste: 0.1)
		@crit = crit
		@haste = haste
		@fury = 0
	end

	def rollCrit
		rand <= @crit
	end

	def hasFury(f)
		f >= @fury
	end

	def consumeFury(f)
		if hasFury(f) then
			@fury -= f
		else
			false
		end
	end

	def inspect
		[@crit, @haste]
	end
end

def mh
	puts "MAIN HAND"
end

def oh
	puts "OFF HAND"
end

def global
	puts "GLOBAL"
end

plr = Player.new(crit: 0.25, haste: 0.25)

# Combat Loop
Iterations = 25

elapsedTime = 0

stats = Hash.new(0)

timers = [ CombatEvent.new(:mh, 2.6, 0) { |a| p a } , CombatEvent.new(:oh, 2.6, 0.5), CombatEvent.new(:global, 1.5, 0) ]

Iterations.times do
	printf("@%.2fs\n", elapsedTime)

	timers.each do |t|
		if t.ready?(elapsedTime) then
			printf("%-6s: %.2f\n", t.name, elapsedTime)
			t.advance
			t.activate(plr) unless t.nil?
		end
	end

	lowest = timers.map { |t| t.timer }.min

	elapsedTime = lowest
	puts
end


# printf("DPS:  %.2f\n", totalDamage / elapsedTime)
