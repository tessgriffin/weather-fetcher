require "rails_helper"

RSpec.describe WeatherService, type: :model do
  describe "#current_temperature_data" do
    it "returns the temperature when given an zip" do
      response = {"coord":{"lon":-106.5749,"lat":35.0726},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"base":"stations","main":{"temp":53.76,"feels_like":49.96,"temp_min":48.04,"temp_max":62.24,"pressure":1016,"humidity":24,"sea_level":1016,"grnd_level":831},"visibility":10000,"wind":{"speed":1.01,"deg":148,"gust":3},"clouds":{"all":5},"dt":1732383542,"sys":{"type":2,"id":2004872,"country":"US","sunrise":1732369766,"sunset":1732406202},"timezone":-25200,"id":0,"name":"Albuquerque","cod":200}.to_json
      stub_request(:get, "https://api.openweathermap.org/data/2.5/weather?APPID=#{ENV['OPEN_WEATHER_MAP_API_KEY']}&units=imperial&zip=87108").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v2.12.1'
        }).
      to_return(status: 200,
                body: response,
                headers: {})
      service = WeatherService.new

      expect(service.current_temperature_data(zip: "87108")["temp"]).to eq(53.76)
    end

    it "returns the temperature when given a city" do
      response = {"coord":{"lon":-106.5749,"lat":35.0726},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"base":"stations","main":{"temp":53.76,"feels_like":49.96,"temp_min":48.04,"temp_max":62.24,"pressure":1016,"humidity":24,"sea_level":1016,"grnd_level":831},"visibility":10000,"wind":{"speed":1.01,"deg":148,"gust":3},"clouds":{"all":5},"dt":1732383542,"sys":{"type":2,"id":2004872,"country":"US","sunrise":1732369766,"sunset":1732406202},"timezone":-25200,"id":0,"name":"Albuquerque","cod":200}.to_json
      stub_request(:get, "https://api.openweathermap.org/data/2.5/weather?APPID=#{ENV['OPEN_WEATHER_MAP_API_KEY']}&q=Albuquerque&units=imperial").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v2.12.1'
        }).
      to_return(status: 200,
                body: response,
                headers: {})
      service = WeatherService.new

      expect(service.current_temperature_data(city: "Albuquerque")["temp"]).to eq(53.76)
    end

    it "returns nil when no input" do
      response = {"cod":"400","message":"Nothing to geocode"}.to_json
      stub_request(:get, "https://api.openweathermap.org/data/2.5/weather?APPID=#{ENV['OPEN_WEATHER_MAP_API_KEY']}&units=imperial").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v2.12.1'
        }).
      to_return(status: 200,
                body: response,
                headers: {})
      service = WeatherService.new

      expect(service.current_temperature_data()).to eq(nil)
    end
  end
end