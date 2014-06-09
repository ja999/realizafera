class RenameBroadcastToProduction < ActiveRecord::Migration
  def change
    rename_table :broadcasts, :productions
  end
end
