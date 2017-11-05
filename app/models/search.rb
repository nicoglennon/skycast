class Search < ApplicationRecord
  belongs_to :user
  validates :location_name, :lat, :lng, presence: true
end
