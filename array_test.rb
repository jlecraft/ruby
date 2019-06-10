require 'pp'

class MyClass
	def initialize(*args)
		@struct = Struct.new("Marshal", *args)
		@rows = []
		
		10.times do
			@rows << @struct.new(*Array.new(args.size) { rand(20) })
		end
	end
	
	def marshal_load(array)
		@struct = Struct.new("Marshal", *array.first)
		@rows && @rows.clear

		array.last.each do |s|
			
			
	end
	
	def marshal_save
		[
			@struct.members,
			@rows
		]
	end
end

m = MyClass.new(:name, :age, :level)

s = Marshal.dump(m)
t = Marshal.load(s)

pp t
