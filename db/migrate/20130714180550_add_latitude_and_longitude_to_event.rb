class AddLatitudeAndLongitudeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :latitude, :floate
    add_column :events, :longitude, :float
  end
end
