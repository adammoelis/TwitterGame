class User < ActiveRecord::Base
  has_many :tweets, dependent: :destroy

  def slug
    name.downcase.gsub(" ","_").gsub(".","")
  end

  def make_img_folder
    FileUtils::mkdir_p "app/assets/images/#{slug}"
  end

  def select_random_image
    Dir.entries("app/assets/images/#{slug}").drop(2).sample
  end




end
