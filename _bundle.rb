require 'rubygems'
require 'zip'

myFileName = File.basename($0, File.extname($0))
workingDir = File.dirname($0)
saveFile   = "#{myFileName}.zip"

Zip.continue_on_exists_proc = true

Zip::File.open(saveFile, Zip::File::CREATE) do |zipfile|
	Dir.glob(File.join('**', '*')) do |fileName|
		next if fileName =~ /#{saveFile}/ or File.directory?(saveFile)
		puts "Adding: #{fileName}"
		zipfile.add(fileName, fileName)
	end
end