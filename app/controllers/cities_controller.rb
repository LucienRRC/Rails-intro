class CitiesController < ApplicationController
  def show
    @city = City.find(params[:id])
    @record_count = @city.weather_records.count
    @latest_recorded_on = @city.weather_records.maximum(:recorded_on)
    @records_per_page = 10
    @current_page = [params[:page].to_i, 1].max
    @total_pages = (@record_count.to_f / @records_per_page).ceil
    @weather_records = @city.weather_records
                            .includes(:weather_code_detail)
                            .order(recorded_on: :desc)
                            .limit(@records_per_page)
                            .offset((@current_page - 1) * @records_per_page)

    render inline: Rails.root.join("app/views/cities/show.html.erb").read,
           type: :erb
  end
end
