class Itinerary < ApplicationRecord
belongs_to :user
has_many :itineraried_places
has_many :places, through: :itineraried_places

# validates :area, presence: true
end
