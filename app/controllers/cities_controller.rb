class CitiesController < ApplicationController
  def show
    @city = City.find(params[:id])
    @record_count = @city.weather_records.count
    @latest_recorded_on = @city.weather_records.maximum(:recorded_on)
    @weather_records = @city.weather_records.order(recorded_on: :desc)

    render inline: Rails.root.join("app/views/cities/show.html.erb").read,
           type: :erb
  end
end
