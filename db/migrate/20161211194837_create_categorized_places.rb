class CreateCategorizedPlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :categorized_places do |t|
      t.integer :place_id
      t.integer :category_id

      t.timestamps
    end
  end
end
