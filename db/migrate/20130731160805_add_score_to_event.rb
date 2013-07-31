class AddScoreToEvent < ActiveRecord::Migration
  def change
    add_column :events, :score, :float
  end
end
