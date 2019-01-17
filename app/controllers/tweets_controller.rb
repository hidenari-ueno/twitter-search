class TweetsController < ApplicationController

  require 'Twitter'

  user_id = ARGV[0]
  before_action :twitter_client, except: :new

  def twitter_client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key       = ENV['TWITTER_COMSUMER_KEY']
      config.consumer_secret    = ENV['TWITTER_COMSUMER_SECRET_KEY']
      config.access_token       = ENV['TWITTER_ACCESS_TOKEN_KEY']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET_KEY']
  end

  @tweets =[]
  since_id = nil

  if params[:keyword].present?
    tweets = client.search(params[:keyword], count: 100, result_type: "recent", exculde: "retweets", since_id: since_id)

    tweets.take(100).each do |tw|
      tweet = Tweet.new(tw.full_text)
      @tweets << tweet
    end

  end

    respond_to do |format|
      format.html
      format.json { render json: @tweets }
    end

# # checking to tweet rhythm
#   tweet_counts = []
#   (0..23).each { |i| tweet_counts[i] = 0}

#   client.user_timeline("@user_name", { count: 200 }).each do |tweet|
#     tweet_counts[tweet.created_at.hour] += 1
#   end

#   (0..23).each do |i|
#     bar = "#" * tweet_counts[i]
#     print "%02d #{bar}\n" % i
#   end

# display user infomation
  # puts client.user("@riputun_jwars").name
  # puts client.user("@riputun_jwars").description
  # puts client.user("@riputun_jwars").tweets_count

  # client.user_timeline("@riputun_jwars", { count: 50 }).each do |tweet|
  #   puts tweet.user.name
  #   puts tweet.full_text
  #   puts "FAVORITE: #{tweet.favorite_count}"
  #   puts "RETWEET : #{tweet.retweet_count}"
  # end

  end

end
