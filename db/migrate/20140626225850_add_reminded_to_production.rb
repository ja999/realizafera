class AddRemindedToProduction < ActiveRecord::Migration
  def change
    add_column :productions, :reminded, :boolean, default: false
  end
end
