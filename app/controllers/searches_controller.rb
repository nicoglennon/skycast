class SearchesController < ApplicationController

  def new
    @search = Search.new
    @history = helpers.current_user.searches.last(5).reverse
  end

  def create
    @search = Search.new

    # geolocation service
    geolocation_response = GeolocationService.new(params["location"]).json_request

    if geolocation_response['status'] == "OK"
      location_name = GeolocationService.location_name(geolocation_response)
      coordinates = GeolocationService.coordinates(geolocation_response)

      # weather service
      weather_response = WeatherService.new(coordinates).json_request

      current_weather = WeatherService.current_weather(weather_response)

      two_day_hourly_weather = WeatherService.two_day_hourly_weather(weather_response)

      week_daily_weather = WeatherService.week_daily_weather(weather_response)

      # update the Search object with response values
      @search.assign_attributes({
        search_term: params["location"],
        location_name: location_name,
        lat: coordinates['lat'],
        lng: coordinates['lng'],
        }
      )

      #associate search with current_user
      @search.user = helpers.current_user

      ## virtual weather object
      @weather = {
            search_term: params["location"],
            location_name: location_name,
            lat: coordinates['lat'],
            lng: coordinates['lng'],
            current_weather: current_weather,
            two_day_hourly_weather: two_day_hourly_weather,
            week_daily_weather: week_daily_weather
          }

      if @search.save
        render 'show'
      else
        @error = "ERROR - Search object not valid!"
        render 'new'
      end
    else
      @error = "ERROR - geolocation response is not OK!"
      render 'new'
    end

  end

  def show
    @search = Search.find(params[:id])
  end
end
