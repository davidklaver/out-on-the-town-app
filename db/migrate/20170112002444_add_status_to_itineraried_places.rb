class AddStatusToItinerariedPlaces < ActiveRecord::Migration[5.0]
  def change
  	add_column :itineraried_places, :status, :string
  end
end
