class CountriesController < ApplicationController
  def index
    @countries = City
                 .left_joins(:weather_records)
                 .group(:country)
                 .order(:country)
                 .select("cities.country, COUNT(DISTINCT cities.id) AS cities_count, COUNT(weather_records.id) AS weather_records_count")

    render inline: Rails.root.join("app/views/countries/index.html.erb").read,
           type: :erb
  end

  def show
    @country = params[:country]
    @cities = City.includes(:weather_records).where(country: @country).order(:name)

    render inline: Rails.root.join("app/views/countries/show.html.erb").read,
           type: :erb
  end
end
