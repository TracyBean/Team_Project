class AddEventtimeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_time, :datetime
    remove_column :events, :date, :date
    remove_column :events, :time, :time
  end
end
