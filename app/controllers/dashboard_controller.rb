class DashboardController < ApplicationController
  def index
    @city_count = City.count
    @weather_record_count = WeatherRecord.count
    @latest_recorded_on = WeatherRecord.maximum(:recorded_on)
    @query = params[:q].to_s.strip
    @selected_country = params[:country].to_s.strip
    @countries = City.distinct.order(:country).pluck(:country)
    @cities = City.includes(:weather_records).order(:country, :name)

    if @selected_country.present?
      @cities = @cities.where(country: @selected_country)
    end

    if @query.present?
      pattern = "%#{ActiveRecord::Base.sanitize_sql_like(@query)}%"
      @cities = @cities.where("name LIKE :query OR country LIKE :query", query: pattern)
    end

    render inline: Rails.root.join("app/views/dashboard/index.html.erb").read,
           type: :erb
  end
end
