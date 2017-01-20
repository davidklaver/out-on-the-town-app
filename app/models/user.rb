class User < ApplicationRecord
has_secure_password
has_many :itineraried_places
has_many :itineraries, through: :itineraried_places

	# validates :username, presence: true, uniqueness: true
	# validates :email, presence: true, uniqueness: true
	# validates :password, presence: true, confirmation: true, uniqueness: true
	# validates_format_of :email, :with => /@/
	# validates :password_confirmation, presence: true
	# validates :password, length: { minimum: 6 }
end
