class WeatherRecord < ApplicationRecord
  belongs_to :city
  belongs_to :weather_code_detail,
             class_name: "WeatherCode",
             foreign_key: :weather_code,
             primary_key: :code,
             optional: true

  validates :recorded_on, presence: true, uniqueness: { scope: :city_id }
end
