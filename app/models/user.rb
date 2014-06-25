class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable

  validates :email, :first_name, :last_name, presence: true

  has_many :free_spots
  has_many :productions
end
