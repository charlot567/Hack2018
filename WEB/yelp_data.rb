require 'open-uri'

open('https://fr.yelp.ca/search?cflt=hiking&find_loc=Montréal%2C+QC') do |file|
    puts file.read
end
