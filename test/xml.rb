require "rexml/document"
require "kconv"

xml_file_name = "sample1.xml"

doc = nil
File.open(xml_file_name) {|xmlfile|
doc = REXML::Document.new(xmlfile)
}

print("--- ", xml_file_name, "\n")

root_element = doc.root
print("root element name = ", root_element.name, "\n")

root_text = root_element.text
print("root text = ", root_text.tosjis, "\n")
