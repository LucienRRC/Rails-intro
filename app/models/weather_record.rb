class WeatherRecord < ApplicationRecord
  belongs_to :city

  validates :recorded_on, presence: true, uniqueness: { scope: :city_id }
end
