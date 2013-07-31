class Event < ActiveRecord::Base
  attr_accessible :date, :description, :name, :address, :event_time, :latitude, :longitude, :category_ids, :url, :source, :score
  has_and_belongs_to_many :categories

   #searchable do
    #text :title, :default_boost => 2
    #text :body
  #end

  #geocoded_by :address
  #after_validation :geocode

  acts_as_gmappable :latitude => 'latitude', :longitude => 'longitude', :process_geocoding => :geocode?,
                  :address => "address", :normalized_address => "address", :validation => false,
                  :msg => "Sorry, not even Google could figure out where that is"

  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?)) || address_changed?
  end

  def gmaps4rails_address
  	"#{self.address}"
  end
end
