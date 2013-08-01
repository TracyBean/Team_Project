class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :tv
      t.string :drink
      t.string :movie
      t.string :music

      t.timestamps
    end
  end
end
