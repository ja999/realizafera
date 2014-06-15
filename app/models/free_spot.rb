class FreeSpot < ActiveRecord::Base
  belongs_to :user
  validate :start_day, :end_day,       inclusion: { in: (0..6)  }
  validate :start_hour, :end_hour,     inclusion: { in: (0..23) }
  validate :start_minute, :end_minute, inclusion: { in: (0..59) }
end
