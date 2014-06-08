class CreateFreeSpots < ActiveRecord::Migration
  def up
    create_table :free_spots do |t|
      t.integer :start_day
      t.integer :start_hour
      t.integer :end_day
      t.integer :end_hour
      t.boolean :repetitive

      t.references :user, index: true
    end
  end

  def down
    drop_table :free_spots
  end
end
