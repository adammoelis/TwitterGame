class User < ActiveRecord::Base
  has_many :tweets, dependent: :destroy

  # def slug
  #   @name.downcase.gsub(" ","_")
  # end
  #
  # def write_to_file
  #   File.open("tweets/#{slug}.txt", 'w') { |file| filter_tweets.each {|tweet| file.puts(tweet)}}
  # end
  #
  # def create_tweet_objects
  #   filter_tweets.each do |tweet|
  #     self.create_tweet(text: tweet)
  #   end
  # end




end
