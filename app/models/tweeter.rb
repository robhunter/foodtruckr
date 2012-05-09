class Tweeter
  include Mongoid::Document
  
  has_many :tweets
  
  #twitter fields
  field :name                               , type: String
  field :is_translator                      , type: Boolean
  field :profile_link_color                 , type: String
  field :time_zone                          , type: String
  field :profile_image_url_https            , type: String
  field :profile_background_image_url_https , type: String
  field :friends_count                      , type: Fixnum
  field :id_str                             , type: String
  field :default_profile_image              , type: Boolean
  field :profile_use_background_image       , type: Boolean
  field :following                          , type: Boolean
  field :favourites_count                   , type: Fixnum
  field :utc_offset                         , type: Fixnum
  field :profile_text_color                 , type: String
  field :notifications                      , type: Boolean
  field :name                               , type: String
  field :profile_sidebar_border_color       , type: String
  field :screen_name                        , type: String
  field :url                                , type: String
  field :protected                          , type: Boolean
  field :created_at                         , type: Time
  field :statuses_count                     , type: Fixnum
  field :profile_background_tile            , type: Boolean
  field :default_profile                    , type: Boolean
  field :profile_sidebar_fill_color         , type: String
  field :description                        , type: String
  field :contributors_enabled               , type: Boolean
  field :geo_enabled                        , type: Boolean
  field :profile_image_url                  , type: String
  field :location                           , type: String
  field :followers_count                    , type: Fixnum
  field :show_all_inline_media              , type: Boolean
  field :lang                               , type: String
  field :follow_request_sent                , type: Boolean
  field :profile_background_color           , type: String
  field :verified                           , type: Boolean
  field :listed_count                       , type: Fixnum
  field :status                             , type: Hash
  field :profile_background_image_url       , type: String
  
  #foodtruckr fields
  field :ft_address                         , type: String
  field :address_valid_until                , type: Time
end