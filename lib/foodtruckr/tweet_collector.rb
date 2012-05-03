module Foodtruckr
  class TweetCollector
    
    @@per_page = 100
    
    def self.get_tweets(page_count=1)
      tweets = Tweet.order_by(:created_at, :desc).limit(page_count * @@per_page).entries.inject({}) do |result, element|
        result[element.id_str] = element
        result
      end
      page_count.times do |i|
        puts "Twitter.list_timeline('robhunter', 'food-trucks', :page=>#{i+1}, :per_page => 100)"
        Twitter.list_timeline('robhunter', 'food-trucks', :page=>(i+1), :per_page => 100).each do |tweet|
          if tweets[tweet.attrs['id_str']].nil?
            t = Tweet.create(tweet.attrs)
          end
        end
      end
    end
    
  end
end