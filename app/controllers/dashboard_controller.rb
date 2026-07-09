class DashboardController < ApplicationController
  def index
    @city_count = City.count
    @weather_record_count = WeatherRecord.count
    @latest_recorded_on = WeatherRecord.maximum(:recorded_on)
    @cities = City.includes(:weather_records).order(:country, :name)

    render inline: Rails.root.join("app/views/dashboard/index.html.erb").read,
           type: :erb
  end
end
