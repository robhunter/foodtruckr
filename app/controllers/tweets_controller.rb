class TweetsController < ApplicationController
  before_filter :nilify_empty_strings, :only => :create
  
  def index
    @tweets = Tweet.order_by(:created_at, :desc).entries
  end
  
end
