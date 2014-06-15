class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable

  has_many :free_spots
end
