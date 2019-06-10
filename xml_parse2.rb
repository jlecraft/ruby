require 'rexml/document'
require 'zip/zip'
 
shared_strings, sheet1 = nil
 
Zip::ZipFile.open('data/test.xlsx') do |z|
	shared_strings = z.read("xl/sharedStrings.xml")
	sheet1 = z.read("xl/worksheets/sheet1.xml")
end
 
doc = REXML::Document.new(shared_strings)
fields = REXML::XPath.match(doc, "//si/t/text()").map { |v| v.to_s.to_sym }
 
doc = REXML::Document.new(sheet1)
 
REXML::XPath.each(doc, "//c/v") do |e|
	p e.parent.parent.attributes["r"]
	p e.text
	puts '-' * 80	
end

__END__
h = Hash[REXML::XPath.each(doc, "//sheetData/row/c").map do |e|
	v = e.children.last ? e.children.last.text : nil
	[
		e.attributes["r"],
		(e.attributes["t"] == "s" ? fields[v.to_i] : v)
	]
end]
 
last_column = h.keys.find_all { |v| v =~ /[A-Z]+1$/ }.max.sub(/\d+/, '')
row = 1
 
# puts "LAST COLUMN = '#{last_column}'"
 
while (h["A#{row}"])
	puts ("A"..last_column).map { |v| h["#{v}#{row}"] } * "\t"
	row += 1
end
 
__END__
("A"..last_column).each do |column|
                cell = "#{column}#{row}"
                puts "#{cell}:#{h[cell]}"
end
 
# p fields = REXML::XPath.match(doc, "//sheetData/c")