class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable

  validates :email, :first_name, :last_name, presence: true
  validates :password, length: { in: 6..128 }
  validates :password_confirmation, length: { in: 6..128 }, on: :update
  validate :matching_passwords, on: :update

  has_many :free_spots
  has_many :productions

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation

  def got_free_spot_for production
  	flag = false
  	self.free_spots.all.each do |spot|
  		if spot.enough_for(production)
  			flag = true
  		end
  	end

  	return flag
  end

  def is_admin?
    admin
  end

  private

  def matching_passwords
    errors.add(:given_passwords, 'do not match') unless password_confirmation == password
  end
end
