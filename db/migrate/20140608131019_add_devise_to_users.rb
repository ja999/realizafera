class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
    end

    add_index :users, :email, unique: true
  end

  def self.down
    change_table(:users) do |t|
      t.remove :email
      t.remove :encrypted_password
    end
  end
end
