class User < ApplicationRecord
  has_many :searches
  validates :username, presence: true, uniqueness: true
end
