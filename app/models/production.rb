class Production < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  validates :start_day, :end_day,       inclusion: { in: (0..6)  }
  validates :start_hour, :end_hour,     inclusion: { in: (0..23) }
  validates :start_minute, :end_minute, inclusion: { in: (0..59) }

  attr_accessible :start_day, :start_hour, :start_minute, :end_day, :end_hour, :end_minute,
                  :repetitive

  def self.incident_with_wday(wday)
    where("
       (start_day <= end_day AND start_day <= ? AND ? <= end_day)
    OR (start_day > end_day AND (start_day <= ? OR ? <= end_day))
    ", wday, wday, wday, wday)
  end
end
