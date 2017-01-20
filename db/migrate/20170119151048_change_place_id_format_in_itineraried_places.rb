class ChangePlaceIdFormatInItinerariedPlaces < ActiveRecord::Migration[5.0]
  def up
    change_column :itineraried_places, :place_id, :string
  end

  def down
    change_column :itineraried_places, :place_id, :integer
  end
end
