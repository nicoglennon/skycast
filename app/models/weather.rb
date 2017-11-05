class Weather < ApplicationRecord
  validates :location_name, :lat, :lng, presence: true
end
