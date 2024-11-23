require "faraday"

class WeatherService
  def connection
    @connection ||= Faraday.new()
  end

  def current_temperature_data(city: nil, zip: nil)
    params = { units: "imperial",
               APPID: ENV['OPEN_WEATHER_MAP_API_KEY'] }
    params[:zip] = zip unless zip.nil?
    params[:q] = city unless city.nil?

    response = connection.get("https://api.openweathermap.org/data/2.5/weather", params)

    JSON.parse(response.body).dig("main")
  end
end