class Itinerary < ApplicationRecord
belongs_to :user
has_many :itineraried_places
has_many :places, through: :itineraried_places

# validates :area, presence: true
def pretty_time
	hour = created_at.strftime("%l").to_i - 5
	created_at.strftime("%A, %b %d, %Y")
end

end
