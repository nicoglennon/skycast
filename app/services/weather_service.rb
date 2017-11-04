require 'httparty'

class WeatherService
  attr_reader :options

  def initialize(params = {})
    @options = { lat: params['lat'].to_s, lng: params['lng'].to_s, key: ENV['WEATHER_KEY'] }
  end

  def self.current_weather(response)
    response["currently"]
  end

  def self.two_day_hourly_weather(response)
    response["hourly"]
  end

  def self.week_daily_weather(response)
    response["daily"]
  end

  def json_request
    HTTParty.get('https://api.darksky.net/forecast/' + options[:key] + '/' + options[:lat] + ',' + options[:lng], format: :json)
  end
end
