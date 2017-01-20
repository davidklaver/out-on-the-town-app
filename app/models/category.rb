class Category < ApplicationRecord
has_many :categorized_places
has_many :places, through: :categorized_places
end
