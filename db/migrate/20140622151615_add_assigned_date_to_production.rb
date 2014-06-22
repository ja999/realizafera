class AddAssignedDateToProduction < ActiveRecord::Migration
  def change
    add_column :productions, :assigned_date, :datetime
  end
end
