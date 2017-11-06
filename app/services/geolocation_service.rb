class GeolocationService
  include HTTParty
  format :json
  base_uri 'https://maps.googleapis.com/maps/api/geocode/json'

  def initialize(params = {})
    @options = { query: { address: params, key: ENV['GEOLOCATION_KEY'] } }
  end

  def self.coordinates(response)
    #return a hash of lat & lng coords of first response
    coordinates_hash = response["results"][0]["geometry"]["location"]
  end

  def self.location_name(response)
    #return location name of first response
    location_hash = response["results"][0]["formatted_address"]
  end

  def json_request
    self.class.get("", @options)
  end
end
