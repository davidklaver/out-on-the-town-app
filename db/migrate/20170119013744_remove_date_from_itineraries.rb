class RemoveDateFromItineraries < ActiveRecord::Migration[5.0]
  def change
  	remove_column :itineraries, :date, :string
  end
end
