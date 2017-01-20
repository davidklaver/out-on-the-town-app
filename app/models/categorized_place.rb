class CategorizedPlace < ApplicationRecord
belongs_to :category
belongs_to :place
end
