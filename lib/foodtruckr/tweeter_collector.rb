module Foodtruckr
  class TweeterCollector
    
    def self.get_tweeters()
      tweeters = Tweeter.order_by(:created_at, :desc).entries.inject({}) do |result, element|
        result[element.id_str] = element
        result
      end
      puts "Twitter.list_members('robhunter', 'food-trucks')"
      Twitter.list_members('robhunter', 'food-trucks').users.each do |tweeter|
        if tweeters[tweeter.attrs['id_str']].nil?
          t = Tweeter.create(tweeter.attrs)
        end
      end
    end
    
  end
end