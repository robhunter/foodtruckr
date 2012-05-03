module Foodtruckr
  class StringLocator
    
    def self.location(text)
      #returns string most likely to get google result if possible
      locations = text.scan(/\d+(?:nd|th|st|rd)\s(?:and|n|&|at)\s[^\s]+/)
      #otherwise return false
    end
    
    def self.highlight_location(text)
      puts 'highlighting'
      puts text
      puts text.gsub(/\d+(?:nd|th|st|rd)\s(?:and|n|&|at)\s[^\s]+/){|s| "<span class=\"highlight\">#{s}</span>"}
      HTMLEntities.new.decode(text).gsub(/\d+(?:nd|th|st|rd)\s(?:and|n|&|at)\s[^\s]+/){|s| "<span class=\"highlight\">#{s}</span>"}
    end
    
  end
end