class Skill
	attr_accessor :name, :rank, :ranks, :maxRank, :uniqueCategories
	attr_accessor :requiredStat, :requiredStatValue

	def initialize(name, stat, statReq, *args)
		@name = name
		@requiredStat = stat.to_sym
		@requiredStatValue = statReq.to_i
		@ranks = args.map(&:to_i)
		@maxRank = @ranks.size
		@rank = 0
		@uniqueCategories = []
	end

	def add_category(category)
		@uniqueCategories << category
	end

	def has_category(category)
		# TODO: handle if category is a list
		@uniqueCategories.detect { |c| c == category }
	end

	def maxRank(level = nil)
		(level.nil? ? @maxRank : @ranks.count { |r| level >= r })
	end

	def to_s
		@name.split(/\s+/).map(&:capitalize).join(' ') + ": #{rank}"
	end

	def inspect
		[@name, @rank]
	end
end

class Player
	STAT_POOL_SIZE = 22 # includes I'm SPECIAL book
	STAT_DIE = 6
	STAT_MAX = 10
	STAT_NAMES = %i(strength perception endurance charisma intelligence agility luck)

	attr_reader :stats, :skills
	attr_reader :level

	def initialize()
		@stats = Hash[Array.new(STAT_NAMES).zip(Array.new(STAT_NAMES.size, 1))]
		@skills = []
		@level = 1
		@skillPoints = 0
	end

	def randomize_stats
		statPool = STAT_POOL_SIZE

		while statPool > 0
			stat = STAT_NAMES.sample
			currentStatValue = @stats[stat]

			maxRoll = [statPool, STAT_DIE].min

			r = rand(1..maxRoll)
			newStatValue = currentStatValue + r

			if newStatValue > STAT_MAX
				newStatValue = STAT_MAX
				r = STAT_MAX - currentStatValue
			end

			@stats[stat] = newStatValue
			statPool = statPool - r

			# printf("%2d -> %2d %s (-%d)\n", currentStatValue, newStatValue, stat, r)
		end
	end

	def add_skill(skill)
		@skills << skill
		skill
	end

	def can_train(skill)
		@stats[skill.requiredStat] >= skill.requiredStatValue
	end

	def random_skill(category = nil)
		@skills.select { |s| category.nil? or s.has_category(category) }.sample
	end

	def random_skill_except(category)
		@skills.reject { |s| s.has_category(category) }.sample
	end

	def increase_level(value = 1)
		@level += value
		@skillPoints += value
	end

	def trainable_skill_ranks(skill, ranksImproved)
		if can_train(skill)
			[skill.maxRank(@level) - skill.rank, ranksImproved, @skillPoints].min
		else
			0
		end
	end

	def train_skill(skill, ranksImproved)
		t = trainable_skill_ranks(skill, ranksImproved)
		@skillPoints -= t
		skill.rank += t
	end

	def to_s
		@stats.map { |k, v| sprintf("%2d %s", v, k.capitalize) }.join("\n")
	end

	def inspect
		[@stats, @level]
	end
end

# ==============================================================
# Create our player
# ==============================================================
plr = Player.new()
plr.randomize_stats

# Add all skills to the player
s = nil
DATA.each_line do |line|
	if (line !~ /^\s|^#/)
		s = plr.add_skill(Skill.new(*(line.chomp.split(/\s*,\s*/))))
	elsif (line =~ /unique:\s+(\w+)/i)
		s.add_category($1.downcase.to_sym) unless s.nil?
	end
end

plr.increase_level(49)

puts "Level #{plr.level}"
puts plr

plr.train_skill(plr.random_skill(:combat), 5)

200.times do
	plr.train_skill(plr.random_skill_except(:combat), 5)
end

puts plr.skills.map { |s| s.rank >= 1 ? s.to_s : nil }.compact	

# stats.each do |statName, statValue|
# 	printf("%2d %s\n", statValue, statName.capitalize)
# end


__END__
iron fist, strength, 1, 1, 9, 18, 31, 46
 unique: combat
big leagues, strength, 2, 1, 7, 15, 27, 42
 unique: combat
armorer, strength, 3, 1, 13, 25, 39
blacksmith, strength, 4, 1, 16, 29
 requires: iron fist, big leagues
heavy gunner, strength, 5, 1, 11, 21, 35, 47
 unique: combat
strong back, strength, 6, 1, 10, 20, 30, 40
steady aim, strength, 7, 1, 28
basher, strength, 8, 1, 5, 14, 26
rooted, strength, 9, 1, 22, 43
 requires: iron fist, big leagues
pain train, strength, 10, 1, 24, 50
pickpocket, perception, 1, 1, 6, 17, 30
 requires: sneak
rifleman, perception, 2, 1, 9, 18, 31, 46
 unique: combat
#awareness, perception, 3, 1
locksmith, perception, 4, 1, 7, 18, 41
demolition expert, perception, 5, 1, 10, 22, 34
night person, perception, 6, 1, 25, 37
refractor, perception, 7, 1, 11, 21, 35, 42
sniper, perception, 8, 1, 13, 26
 requires: rifleman, commando
penetrator, perception, 9, 1, 28
 requires: rifleman, heavy gunner, gunslinger, commando
concentrated fire, perception, 10, 1, 26, 50
toughness, endurance, 1, 1, 9, 18, 31, 46
lead belly, endurance, 2, 1, 6, 17
lifegiver, endurance, 3, 1, 8, 20
chem resistant, endurance, 4, 1, 22
aquaboy, endurance, 5, 1, 21
rad resistant, endurance, 6, 1, 13, 26, 35
adamantium skeleton, endurance, 7, 1, 13, 26
cannibal, endurance, 8, 1, 19, 38
ghoulish, endurance, 9, 1, 24, 48
solar powered, endurance, 10, 1, 27, 50
cap collector, charisma, 1, 1, 20, 41
lady killer, charisma, 2, 1, 7, 22
lone wanderer, charisma, 3, 1, 17, 40, 50
attack dog, charisma, 4, 1, 9, 25
 exclude: lone wanderer
animal friend, charisma, 5, 1, 12, 28
 requires: rifleman, heavy gunner, gunslinger, commando
local leader, charisma, 6, 1, 14
party boy, charisma, 7, 1, 15, 37
inspirational, charisma, 8, 1, 19, 43
 exclude: lone wanderer
wasteland whisperer, charisma, 9, 1, 21, 49
 requires: rifleman, heavy gunner, gunslinger, commando
intimidation, charisma, 10, 1, 23, 50
 requires: rifleman, heavy gunner, gunslinger, commando
#v.a.n.s., intelligence, 1, 1
medic, intelligence, 2, 1, 18, 30, 49
gun nut, intelligence, 3, 1, 13, 25, 39
 requires: rifleman, heavy gunner, gunslinger, commando
hacker, intelligence, 4, 1, 9, 21, 33
scrapper, intelligence, 5, 1, 23, 40
science!, intelligence, 6, 1, 17, 28, 41
chemist, intelligence, 7, 1, 16, 32, 45
robotics expert, intelligence, 8, 1, 19, 44
nuclear physicist, intelligence, 9, 1, 14, 26
nerd rage!, intelligence, 10, 1, 31, 50
gunslinger, agility, 1, 1, 7, 15, 27, 42
 unique: combat
commando, agility, 2, 1, 11, 21, 35, 49
 unique: combat
sneak, agility, 3, 1, 5, 12, 23, 38
mister sandman, agility, 4, 1, 17, 30
 requires: sneak
action boy, agility, 5, 1, 18, 38
moving target, agility, 6, 1, 24, 44
ninja, agility, 7, 1, 16, 33
 requires: sneak
quick hands, agility, 8, 1, 28
blitz, agility, 9, 1, 29
 requires: iron fist, big leagues
gun fu, agility, 10, 1, 26, 50
fortune finder, luck, 1, 1, 5, 25, 40
scrounger, luck, 2, 1, 7, 24, 37
bloody mess, luck, 3, 1, 9, 31, 47
mysterious stranger, luck, 4, 1, 22, 41
idiot savant, luck, 5, 1, 11, 34
better criticals, luck, 6, 1, 15, 40
critical banker, luck, 7, 1, 17, 43, 50
grim reaper's sprint, luck, 8, 1, 19, 46
four leaf clover, luck, 9, 1, 13, 32, 48
ricochet, luck, 10, 1, 29, 50