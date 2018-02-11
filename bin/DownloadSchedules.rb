require 'open-uri'
require 'nokogiri'
require 'pp'

doc = Nokogiri::HTML(open("https://www.majorityleader.gov/weekly-schedule/"))

title = doc.title
#schedule = doc.search('p').map(&:text)
schedule = doc.search('p')
links = doc.css('p strong a')
hrefs = links.map {|link| link.attribute('href').to_s}

# Print data
puts title
pp schedule
pp hrefs
