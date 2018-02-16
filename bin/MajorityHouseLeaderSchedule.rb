require 'open-uri'
require 'nokogiri'
require 'pp'

# Initialize structs
@link_descs = Hash.new{|hsh,key| hsh[key] = {} }
@days_map = Hash.new{|hsh,key| hsh[key] = {} }
#@days_map = Hash.new
@bill_text = Array.new
@links_agg = Array.new
@doc = Nokogiri::HTML(open("https://www.majorityleader.gov/weekly-schedule/"))

def main
  daily_desc = @doc.css('p')
  curr_day = ""
  curr_day_desc = ""

  # Get all links, descriptions, and days
  daily_desc.each do |desc|

    # Get bill descriptions
    sponsor = desc.css('em').text
    bill_desc = desc.children.find {|n| n.text? && n.to_s.include?("–")}.to_s
    bill_desc << sponsor unless sponsor.blank?
    @bill_text << bill_desc unless bill_desc.blank?
    
    # Get link
    link = desc.css('strong a')
    if !link.blank?
      bill = link.text
      @links_agg << bill
      @link_descs[bill] = link.attribute('href').to_s, @bill_text.shift
      @days_map[curr_day] = curr_day_desc, @links_agg.clone
    end
    
    # Get day
    day = desc.css('u').text
    if !day.blank?
      curr_day = day
      curr_day_desc = date_filtered(desc.text)
      @days_map[curr_day] = curr_day_desc
      @links_agg.clear
    end
  end
end

def print
  p @doc.title
  pp @days_map
  pp @link_descs
end

def date_filtered (text)
  text.slice!(/.+?[0-9](TH|RD|ST|ND)/)
  return text
end

main
print
