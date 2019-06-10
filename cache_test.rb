require 'fileutils'

class Cache
	PATH = 'C:/Cache/%s.csh'.freeze
	
	def initialize(*args)
		@file = PATH % [ @name = args.join ]
	end
	
	def save(obj)
		(f = File.open(@file, "w")) ? Marshal.dump(obj, f) : nil
	end
	
	def load(io = nil)
		return unless (File.exists?(@file) && cache = File.open(@file))
		
		io &&= (io.respond_to?(:mtime) ? io.mtime : File.mtime(io))
		
		if (!io || (cache.mtime > io))
			Marshal.load(cache)
		else
			nil
		end
	end
	
	def self.clear(execute = true)
		FileUtils.rm(Dir.glob(PATH % ['*'])) if (execute)
	end
end


#Cache.clear

fields = [:name, :age, :sex, :level, :ninja]
Struct.new("Row", *fields)

c = Cache.new(:test, 3.747)
s = Struct::Row.new('Jonathan', 39, true, 90) unless (s = c.load)
p s
p s.members
c.save(s)

# r = Struct::Row.new("Jonathan", 39, "Yes")
# c.save(r)



__END__
	def self.file(name, mode = "r")
		fname = file_name(name)
		(File.exists?(fname) || mode =~ /w/) ? File.open(fname, mode) : nil
	end
	
