class AboutController < ApplicationController
  def show
    @city_count = City.count
    @weather_record_count = WeatherRecord.count
    @earliest_recorded_on = WeatherRecord.minimum(:recorded_on)
    @latest_recorded_on = WeatherRecord.maximum(:recorded_on)

    render inline: Rails.root.join("app/views/about/show.html.erb").read,
           type: :erb
  end
end
