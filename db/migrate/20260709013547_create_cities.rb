class CreateCities < ActiveRecord::Migration[7.2]
  def change
    create_table :cities do |t|
      t.string :name, null: false
      t.string :country, null: false
      t.decimal :latitude, precision: 10, scale: 6, null: false
      t.decimal :longitude, precision: 10, scale: 6, null: false
      t.string :timezone, null: false

      t.timestamps
    end

    add_index :cities, [:name, :country], unique: true
  end
end
