class WeatherController < ApplicationController
  def index
    if weather_params.present?
      if weather_params[:city].present?
        @weather_data = WeatherService.new.current_temperature_data(city: weather_params["city"])
      elsif weather_params[:zip_code].present?
        zip = weather_params["zip_code"]
        @weather_data = Rails.cache.read(zip)
        if @weather_data.nil?
          @weather_data = WeatherService.new.current_temperature_data(zip: zip)
          Rails.cache.write(zip, @weather_data, expires_in: 30.minutes)
        else
          @cached = true
        end
      end
    end
  end

  private
  
  def weather_params
    params.permit([:city, :zip_code, :commit])
  end
end