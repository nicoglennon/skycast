class SearchesController < ApplicationController

  def new
    @search = Search.new

    if params["type"] == 'timemachine'
      @timemachine = true
    end

    @history = helpers.current_user.searches.last(5).reverse
  end

  def create
    @search = Search.new

    # geolocation service
    geolocation_response = GeolocationService.new(params["location"]).json_request

    if geolocation_response['status'] == "OK"
      location_name = GeolocationService.location_name(geolocation_response)
      coordinates = GeolocationService.coordinates(geolocation_response)


      # update the Search object with response values
      @search.assign_attributes({
        search_term: params["location"],
        location_name: location_name,
        lat: coordinates['lat'],
        lng: coordinates['lng'],
        }
      )

      ## weather service

      #associate search with current_user
      @search.user = helpers.current_user

      #if time machine:
      if params['date']
        weather_response = WeatherService.new(coordinates).time_machine_request(params['date'])

        p weather_response
        @temp = weather_response

        @weather = {
          search_term: params["location"],
          location_name: location_name,
          lat: coordinates['lat'],
          lng: coordinates['lng'],
          time: params['date']
          # current_weather: current_weather,
          # two_day_hourly_weather: two_day_hourly_weather,
          # week_daily_weather: week_daily_weather
        }

      # if forecast:
      else
        weather_response = WeatherService.new(coordinates).json_request

        current_weather = WeatherService.current_weather(weather_response)

        # two_day_hourly_weather = WeatherService.two_day_hourly_weather(weather_response)

        week_daily_weather = WeatherService.week_daily_weather(weather_response)

        ## virtual weather object
        @weather = {
          search_term: params["location"],
          location_name: location_name,
          lat: coordinates['lat'],
          lng: coordinates['lng'],
          current_weather: current_weather,
          # two_day_hourly_weather: two_day_hourly_weather,
          week_daily_weather: week_daily_weather
        }
      end


      if @search.save
        render 'show'
      else
        @error = "Search object did not save!"

        @history = helpers.current_user.searches.last(5).reverse

        render 'new'
      end
    else
      @error = "Geolocation response failed!"

      @history = helpers.current_user.searches.last(5).reverse

      render 'new'
    end
  end

  def show
    @search = Search.find(params[:id])
  end
end
