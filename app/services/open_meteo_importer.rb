require "net/http"
require "json"

class OpenMeteoImporter
  API_URL = "https://archive-api.open-meteo.com/v1/archive"
  DAILY_FIELDS = %w[
    weather_code
    temperature_2m_max
    temperature_2m_min
    temperature_2m_mean
    precipitation_sum
    wind_speed_10m_max
  ].freeze

  def initialize(city, start_date:, end_date:)
    @city = city
    @start_date = start_date
    @end_date = end_date
  end

  def import!
    daily = fetch_daily_weather

    daily.fetch("time").each_with_index do |date, index|
      @city.weather_records.find_or_initialize_by(recorded_on: date).tap do |record|
        record.weather_code = daily["weather_code"][index]
        record.temperature_max = daily["temperature_2m_max"][index]
        record.temperature_min = daily["temperature_2m_min"][index]
        record.temperature_mean = daily["temperature_2m_mean"][index]
        record.precipitation_sum = daily["precipitation_sum"][index]
        record.wind_speed_max = daily["wind_speed_10m_max"][index]
        record.save!
      end
    end
  end

  private

  def fetch_daily_weather
    response = Net::HTTP.get_response(uri)
    raise "Open-Meteo request failed: #{response.code} #{response.message}" unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body).fetch("daily")
  end

  def uri
    URI(API_URL).tap do |uri|
      uri.query = URI.encode_www_form(
        latitude: @city.latitude,
        longitude: @city.longitude,
        start_date: @start_date,
        end_date: @end_date,
        daily: DAILY_FIELDS.join(","),
        timezone: @city.timezone
      )
    end
  end
end
