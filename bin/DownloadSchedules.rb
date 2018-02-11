require 'open-uri'
require 'nokogiri'
require 'pp'

# Initialize structs
@link_map = Hash.new
@days_map = Hash.new
@doc = Nokogiri::HTML(open("https://www.majorityleader.gov/weekly-schedule/"))

def main
  daily_desc = @doc.css('p')
  links = @doc.css('p strong a')
  daily_desc.each do |desc|
    day = desc.css('u').text
    if day.blank? 
      next
    end
    @days_map[day] = filtered(desc.text)
  end

  links.each do |link|
    @link_map[link.text] = link.attribute('href').to_s
  end
end

def print
  p @doc.title
  pp @link_map
  pp @days_map
end

def filtered (text)
  text.slice!(/.+?[0-9](TH|RD|ST|ND)/)
  return text
end

main
print
