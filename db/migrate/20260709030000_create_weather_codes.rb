class CreateWeatherCodes < ActiveRecord::Migration[7.2]
  def change
    create_table :weather_codes do |t|
      t.integer :code, null: false
      t.string :description, null: false
      t.string :category, null: false

      t.timestamps
    end

    add_index :weather_codes, :code, unique: true
  end
end
