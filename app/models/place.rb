class Place < ApplicationRecord
has_many :categorized_places
has_many :categories, through: :categorized_places
has_many :itineraried_places
has_many :users, through: :itineraried_places
end
