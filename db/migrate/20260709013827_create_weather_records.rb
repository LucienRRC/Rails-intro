class CreateWeatherRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :weather_records do |t|
      t.references :city, null: false, foreign_key: true
      t.date :recorded_on, null: false
      t.decimal :temperature_max, precision: 6, scale: 2
      t.decimal :temperature_min, precision: 6, scale: 2
      t.decimal :temperature_mean, precision: 6, scale: 2
      t.decimal :precipitation_sum, precision: 8, scale: 2
      t.decimal :wind_speed_max, precision: 6, scale: 2
      t.integer :weather_code

      t.timestamps
    end

    add_index :weather_records, [:city_id, :recorded_on], unique: true
  end
end
