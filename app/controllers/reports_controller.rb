class ReportsController < ApplicationController
  def index
    @city_summaries = City
                      .joins(:weather_records)
                      .select(
                        "cities.id, cities.name, cities.country",
                        "COUNT(weather_records.id) AS records_count",
                        "AVG(weather_records.temperature_mean) AS average_temperature",
                        "SUM(weather_records.precipitation_sum) AS total_precipitation",
                        "MAX(weather_records.wind_speed_max) AS max_wind_speed"
                      )
                      .group("cities.id", "cities.name", "cities.country")
                      .order("cities.country ASC, cities.name ASC")

    @warmest_city = @city_summaries.max_by { |city| city.average_temperature.to_f }
    @coolest_city = @city_summaries.min_by { |city| city.average_temperature.to_f }
    @wettest_city = @city_summaries.max_by { |city| city.total_precipitation.to_f }
    @windiest_city = @city_summaries.max_by { |city| city.max_wind_speed.to_f }

    render inline: Rails.root.join("app/views/reports/index.html.erb").read,
           type: :erb
  end
end
