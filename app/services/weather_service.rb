require 'httparty'

class WeatherService
  attr_reader :options

  def initialize(params = {})
    @options = { lat: params['lat'].to_s, lng: params['lng'].to_s, key: ENV['WEATHER_KEY'] }
  end

  def self.current_weather(response)
    response["currently"].slice("time", "summary", "icon", "precipProbability", "temperature", "humidity", "windSpeed")
  end

  # def self.two_day_hourly_weather(response)
  #   # new response object (what will be returned)
  #   new_response = {
  #     summary: response["hourly"]["summary"],
  #     icon: response["hourly"]["icon"],
  #     data: []
  #   }
  #
  #   #iterate the response data for attributes and add them to the new_response
  #   response["hourly"]["data"].each do |hour|
  #     hour_sliced = hour.slice("time", "icon", "precipProbability", "temperature")
  #     new_response[:data] << hour_sliced
  #   end
  #
  #   new_response
  # end

  def self.week_daily_weather(response)
    response["daily"]

    new_response = {
      summary: response["daily"]["summary"],
      icon: response["daily"]["icon"],
      data: []
    }

    #iterate the response data for attributes and add them to the new_response
    response["daily"]["data"].each do |hour|
      hour_sliced = hour.slice("time", "icon", "precipProbability", "precipType", "temperatureHigh", "temperatureLow")
      new_response[:data] << hour_sliced
    end

    new_response
  end

  def json_request
    HTTParty.get('https://api.darksky.net/forecast/' + options[:key] + '/' + options[:lat] + ',' + options[:lng], format: :json)
  end

  def time_machine_request(unix_date)
    HTTParty.get('https://api.darksky.net/forecast/' + options[:key] + '/' + options[:lat] + ',' + options[:lng] + ',' + unix_date.to_time.to_i.to_s + '?exclude=currently,daily,minutely,alert,flags', format: :json)
  end
end
