class AddMinutesToEvents < ActiveRecord::Migration
  def up
    change_table :productions do |t|
      t.integer :start_minute
      t.integer :end_minute
    end
    change_table :free_spots do |t|
      t.integer :start_minute
      t.integer :end_minute
    end
  end

  def down
    change_table :productions do |t|
      t.remove :start_minute
      t.remove :end_minute
    end
    change_table :free_spots do |t|
      t.remove :start_minute
      t.remove :end_minute
    end
  end
end
