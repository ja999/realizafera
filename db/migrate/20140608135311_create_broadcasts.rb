class CreateBroadcasts < ActiveRecord::Migration
  def up
    create_table :broadcasts do |t|
      t.integer :start_day
      t.integer :start_hour
      t.integer :end_day
      t.integer :end_hour
      t.boolean :repetitive
      t.boolean :cancelled
      t.boolean :confirmed_by_user

      t.references :user, index: true
    end
  end

  def down
    drop_table :broadcasts
  end
end
