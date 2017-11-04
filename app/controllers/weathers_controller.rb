class WeathersController < ApplicationController

  def new
    @weather = Weather.new
  end

  def create
    @weather = Weather.new

    # geolocation service
    geolocation_response = GeolocationService.new(params["weather"]["location_name"]).json_request

    if geolocation_response['status'] == "OK"
      @location_name = GeolocationService.location_name(geolocation_response)
      @coordinates = GeolocationService.coordinates(geolocation_response)

      # weather service
      weather_response = WeatherService.new(@coordinates).json_request

      current_weather = WeatherService.current_weather(weather_response)

      two_day_hourly_weather = WeatherService.two_day_hourly_weather(weather_response)

      week_daily_weather = WeatherService.week_daily_weather(weather_response)

      # update the Weather object with response values
      @weather.assign_attributes({
          location_name: @location_name,
          lat: @coordinates['lat'],
          lng: @coordinates['lng'],
          current_weather: current_weather['summary'],
          two_day_hourly_weather: two_day_hourly_weather['summary'],
          week_daily_weather: week_daily_weather['summary']
        }
      )
      if @weather.save
        redirect_to weather_path(@weather)
      else
        @error = "ERROR - Weather didn't save!"
        render 'new'
      end
    else
      @error = "ERROR - geolocation response is not OK!"
      render 'new'
    end

  end

  def show
    @weather = Weather.find(params[:id])
  end
end
