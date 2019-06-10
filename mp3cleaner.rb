SafeMode = 1
MusicDirectory = File.join('C:', 'Users', 'Jonathan', 'Music', 'Downloaded')

p badArtists = DATA.each_line.map(&:strip)
badArtistExp = badArtists.join('|')

total = 0

Dir.glob(File.join(MusicDirectory, '**', '*mp3')) do |fullName|
	if fullName =~ /_\d\.mp3/ or fullName =~ /\/#{badArtistExp}/i then
		File.delete(fullName) unless (defined?(SafeMode)).nil?
		puts File.basename(fullName)
		total += 1
	end
end

puts "#{total} files"

__END__
2 chainz
ludicrus
justin bieber
drake
usher
young money
trey songz
t-pain
the foxx
taio cruz
soulja boy