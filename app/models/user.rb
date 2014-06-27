class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable

  validates :email, :first_name, :last_name, presence: true

  has_many :free_spots
  has_many :productions

  def got_free_spot_for production
  	flag = false
  	self.free_spots.all.each do |spot|
  		if spot.enough_for(production)
  			flag = true
  		end
  	end

  	return flag
  end
end
