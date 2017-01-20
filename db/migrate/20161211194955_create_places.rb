class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.string :state_code
      t.string :postal_code
      t.integer :rating
      t.string :hours
      t.string :price
      t.integer :itinerary_id

      t.timestamps
    end
  end
end
