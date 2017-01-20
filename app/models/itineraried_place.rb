class ItinerariedPlace < ApplicationRecord
belongs_to :itinerary
belongs_to :place, optional: true
belongs_to :user
end
