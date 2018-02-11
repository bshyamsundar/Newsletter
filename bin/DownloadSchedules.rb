require 'open-uri'
require 'nokogiri'
require 'pp'

# Initialize structs
@link_descs = Hash.new{|hsh,key| hsh[key] = {} }
@days_map = Hash.new
@bill_descs = Array.new
@doc = Nokogiri::HTML(open("https://www.majorityleader.gov/weekly-schedule/"))

def main
  daily_desc = @doc.css('p')
  links = @doc.css('p strong a')

  # Get each day and summary
  daily_desc.each do |desc|
    day = desc.css('u').text
    sponsor = desc.css('em').text
    all_text = desc.children.find {|n| n.text? && n.to_s.include?("–")}.to_s
    all_text << sponsor unless sponsor.blank?
    if day.blank? && all_text.blank? 
      next
    elsif day.blank? && !all_text.blank?
      @bill_descs << all_text
    elsif !day.blank? && all_text.blank?
      @days_map[day] = date_filtered(desc.text)
    else
      @days_map[day] = date_filtered(desc.text)
      @bill_descs << all_text
    end
  end

  links.each do |link|
    @link_descs[link.text] = link.attribute('href').to_s, @bill_descs.shift
  end
end

def print
  p @doc.title
  pp @link_descs
  pp @days_map
end

def date_filtered (text)
  text.slice!(/.+?[0-9](TH|RD|ST|ND)/)
  return text
end

main
print
