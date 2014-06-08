class CreateUsers < ActiveRecord::Migration
  def up
    create_table(:users) do |t|
      t.timestamps

      t.string :first_name
      t.string :last_name
      t.string :type
    end
  end

  def down
    drop_table :users
  end
end
