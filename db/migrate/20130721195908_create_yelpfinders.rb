class CreateYelpfinders < ActiveRecord::Migration
  def change
    create_table :yelpfinders do |t|

      t.timestamps
    end
  end
end
