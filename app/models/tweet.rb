class Tweet
  include Mongoid::Document
  
  belongs_to :tweeter
  
  field :name                     , type: String
  field :retweeted                , type: String
  field :in_reply_to_screen_name  , type: String
  field :possibly_sensitive       , type: String
  field :contributors             , type: String
  field :coordinates              , type: Hash
  field :place                    , type: Hash
  field :user                     , type: Hash
  field :retweet_count            , type: Fixnum
  field :id_str                   , type: String
  field :in_reply_to_user_id      , type: String
  field :favorited                , type: String
  field :in_reply_to_status_id_str, type: String
  field :in_reply_to_status_id    , type: String
  field :source                   , type: String
  field :created_at               , type: Time
  field :in_reply_to_user_id_str  , type: String
  field :truncated                , type: String
  field :id                       , type: String
  field :geo                      , type: Hash
  field :text                     , type: String
  
  
  
  
  def pretty_text
    #replace @twitter_handle with link to twitter
    t = text.gsub(/(http|https):\/\/{1}[^\s]+/){|s| "<a target=\"_blank\" href=\"#{s}\">#{s}</a>"}
    #give links <a> tags
    t.gsub!(/@\w+/){|s| "<a target=\"_blank\" href=\"https://twitter.com/#!/#{s[1..-1]}\">#{s}</a>"}
    #TODO try to give pic links imgs    
    t
  end
  
  def coordinates_str
    "[#{coordinates['coordinates'][1]}, #{coordinates['coordinates'][0]}]"
  end
  
  def coordinates_url
      "http://maps.google.com/maps?q=#{coordinates['coordinates'][1]},#{coordinates['coordinates'][0]}+(#{user['name']})&z=14&ll=#{coordinates['coordinates'][1]},#{coordinates['coordinates'][0]}" unless (coordinates.nil? || user.nil?)
  end
  
end