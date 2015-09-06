class User < ActiveRecord::Base
  has_many :tweets, dependent: :destroy
  has_many :user_accounts, dependent: :destroy
  has_many :accounts, through: :user_accounts


  def slug
    name.downcase.gsub(" ","_").gsub(".","")
  end

  def make_img_folder
    FileUtils::mkdir_p "app/assets/images/#{slug}"
  end

  def select_random_image
    Dir.entries("app/assets/images/#{slug}").drop(2).sample
  end

  def remove_from_default
    self.default = false
    self.save
  end

  def add_to_default_game
    self.default = true
    self.save
  end

  def self.default_twitter_accounts
    User.where(default: true)
  end

  def set_temp_default
    # if self.republican
    #   session[:republican_default] = self.name
    # elsif self.democrat
    #   session[:democrat_default] = self.name
    # elsif self.jerseyshore
    #   session[:jerseyshore_default] = self.name
    # end
  end





end
