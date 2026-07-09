cities = [
  { name: "Winnipeg", country: "Canada", latitude: 49.8951, longitude: -97.1384, timezone: "America/Winnipeg" },
  { name: "Toronto", country: "Canada", latitude: 43.6532, longitude: -79.3832, timezone: "America/Toronto" },
  { name: "Vancouver", country: "Canada", latitude: 49.2827, longitude: -123.1207, timezone: "America/Vancouver" },
  { name: "New York", country: "United States", latitude: 40.7128, longitude: -74.0060, timezone: "America/New_York" },
  { name: "Chicago", country: "United States", latitude: 41.8781, longitude: -87.6298, timezone: "America/Chicago" },
  { name: "Los Angeles", country: "United States", latitude: 34.0522, longitude: -118.2437, timezone: "America/Los_Angeles" },
  { name: "London", country: "United Kingdom", latitude: 51.5072, longitude: -0.1276, timezone: "Europe/London" },
  { name: "Tokyo", country: "Japan", latitude: 35.6762, longitude: 139.6503, timezone: "Asia/Tokyo" }
]

start_date = Date.new(2025, 7, 1)
end_date = Date.new(2025, 7, 14)

cities.each do |attributes|
  city = City.find_or_create_by!(name: attributes[:name], country: attributes[:country]) do |record|
    record.latitude = attributes[:latitude]
    record.longitude = attributes[:longitude]
    record.timezone = attributes[:timezone]
  end

  city.update!(attributes)
  OpenMeteoImporter.new(city, start_date: start_date, end_date: end_date).import!
end

puts "Imported #{City.count} cities and #{WeatherRecord.count} weather records."
