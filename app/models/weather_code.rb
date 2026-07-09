class WeatherCode < ApplicationRecord
  has_many :weather_records, foreign_key: :weather_code, primary_key: :code, dependent: :nullify

  validates :code, presence: true, uniqueness: true
  validates :description, :category, presence: true
end
