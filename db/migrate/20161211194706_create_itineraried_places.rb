class CreateItinerariedPlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :itineraried_places do |t|
      t.integer :place_id
      t.integer :user_id
      t.integer :itinerary_id

      t.timestamps
    end
  end
end
