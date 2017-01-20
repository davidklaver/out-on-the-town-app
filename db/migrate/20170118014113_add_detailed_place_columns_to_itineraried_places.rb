class AddDetailedPlaceColumnsToItinerariedPlaces < ActiveRecord::Migration[5.0]
  def change
  	add_column :itineraried_places, :name, :string
  	add_column :itineraried_places, :price_level, :integer
  	add_column :itineraried_places, :rating, :float
  	add_column :itineraried_places, :address, :string
  	add_column :itineraried_places, :phone, :string
  	add_column :itineraried_places, :google_maps_url, :string
  	add_column :itineraried_places, :website, :string
  	add_column :itineraried_places, :lat, :float
  	add_column :itineraried_places, :lng, :float
  	add_column :itineraried_places, :type1, :string
  	add_column :itineraried_places, :type2, :string
  	add_column :itineraried_places, :monday_hours, :string
  	add_column :itineraried_places, :tuesday_hours, :string
  	add_column :itineraried_places, :wednesday_hours, :string
  	add_column :itineraried_places, :thursday_hours, :string
  	add_column :itineraried_places, :friday_hours, :string
  	add_column :itineraried_places, :saturday_hours, :string
  	add_column :itineraried_places, :sunday_hours, :string
  end
end

# hours: opening_hours,

