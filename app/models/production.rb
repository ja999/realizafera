class Production < ActiveRecord::Base
  validate :start_day, :end_day,       inclusion: { in: (0..6)  }
  validate :start_hour, :end_hour,     inclusion: { in: (0..23) }
  validate :start_minute, :end_minute, inclusion: { in: (0..59) }

  def self.incident_with_wday(wday)
    where("
       (start_day <= end_day AND start_day <= ? AND ? <= end_day)
    OR (start_day > end_day AND (start_day <= ? OR ? <= end_day))
    ", wday, wday, wday, wday)
  end
end
