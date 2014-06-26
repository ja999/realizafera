class AddDefaultValueToCancelledInProductions < ActiveRecord::Migration
  def change
    change_column :productions, :cancelled, :boolean, default: false
  end
end
