class CreateCategoriesEvents < ActiveRecord::Migration
  def up
      create_table :categories_events, :id => false do |t|
          t.belongs_to :category
          t.belongs_to :event
      end
  end

  def down
      drop_table :categories_events
  end
end
