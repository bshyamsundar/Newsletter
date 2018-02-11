require 'open-uri'
require 'nokogiri'
require 'pp'

doc = Nokogiri::HTML(open("https://www.majorityleader.gov/weekly-schedule/"))

title = doc.title
schedule = doc.search('p').map(&:text)

# Print data
puts title
pp schedule
