class GetTweets
  @queue = :main
  
  def self.perform
    
    Foodtruckr::TweetCollector.get_tweets
    
  end
  
end
