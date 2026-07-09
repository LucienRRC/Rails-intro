class DashboardController < ApplicationController
  def index
    @city_count = City.count
    @weather_record_count = WeatherRecord.count
    @latest_recorded_on = WeatherRecord.maximum(:recorded_on)
    @query = params[:q].to_s.strip
    @cities = City.includes(:weather_records).order(:country, :name)

    if @query.present?
      pattern = "%#{ActiveRecord::Base.sanitize_sql_like(@query)}%"
      @cities = @cities.where("name LIKE :query OR country LIKE :query", query: pattern)
    end

    render inline: Rails.root.join("app/views/dashboard/index.html.erb").read,
           type: :erb
  end
end
