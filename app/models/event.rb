class Event < ActiveRecord::Base
  attr_accessible :date, :description, :name, :address, :time, :latitude, :longitude

  geocoded_by: address
  after_validation :geocode
end
