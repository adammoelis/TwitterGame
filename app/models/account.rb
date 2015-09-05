class Account < ActiveRecord::Base
  has_many :user_accounts, dependent: :destroy
  has_many :users, through: :user_accounts
  has_many :tweets, through: :users

  def self.find_or_create_from_auth_hash(auth_hash)
    account = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
    account.update(name: auth_hash.info.name, profile_image: auth_hash.info.image, token: auth_hash.credentials.token,
    secret: auth_hash.credentials.secret)
    account
  end

  def twitter
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = token
      config.access_token_secret = secret
    end
  end

  def add_user(user_object)
    self.users << user_object unless self.users.include?(user_object)
  end

  def remove_user(user_object)
    self.users.delete(user_object) << user_object if self.users.include?(user_object)
  end



end
