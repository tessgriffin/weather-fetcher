require "rails_helper"

RSpec.describe "Weather", type: :request do
  describe "Get the weather" do
    it "assigns weather data properly" do
      response = {"coord":{"lon":-106.5749,"lat":35.0726},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"base":"stations","main":{"temp":53.76,"feels_like":49.96,"temp_min":48.04,"temp_max":62.24,"pressure":1016,"humidity":24,"sea_level":1016,"grnd_level":831},"visibility":10000,"wind":{"speed":1.01,"deg":148,"gust":3},"clouds":{"all":5},"dt":1732383542,"sys":{"type":2,"id":2004872,"country":"US","sunrise":1732369766,"sunset":1732406202},"timezone":-25200,"id":0,"name":"Albuquerque","cod":200}
      stub_request(:get, "https://api.openweathermap.org/data/2.5/weather?APPID=3549f0a07f80a4bfa4e105132c84e3c6&units=imperial&zip=87108").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v2.12.1'
        }).
      to_return(status: 200, body: response.to_json, headers: {})

      get weather_index_path, params: { zip_code: "87108" }

      expect(response[:main][:temp]).to eq(53.76)
    end
  end
end