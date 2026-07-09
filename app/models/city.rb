class City < ApplicationRecord
  has_many :weather_records, dependent: :destroy

  validates :name, :country, :latitude, :longitude, :timezone, presence: true
  validates :name, uniqueness: { scope: :country }
end
