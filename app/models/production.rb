class Production < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user

  validates :start_day,                 inclusion: { in: (0..6)  }
  validates :end_day,                   inclusion: { in: (0..7)  }
  validates :start_hour, :end_hour,     inclusion: { in: (0..23) }
  validates :start_minute, :end_minute, inclusion: { in: (0..59) }

  validate :too_long_validator
  validate :too_short_validator
  before_validation :check_end_day

  attr_accessible :start_day,
                  :start_hour,
                  :start_minute,
                  :end_day,
                  :end_hour,
                  :end_minute,
                  :repetitive,
                  :user_id

  DAYS = ['niedziela', 'poniedziałek', 'wtorek', 'środa', 'czwartek', 'piątek', 'sobota']

  def self.incident_with_wday(wday)
    where('start_day <= ? AND ? <= end_day', wday, wday)
  end

  private

  def check_end_day
    self.end_day += 7 if self.start_day > self.end_day
  end

  def too_long_validator
    too_long = (end_day - start_day > 1) || (end_day < start_day)
    errors.add(:end_day, "You can't define a production longer than day") if too_long
  end

  def too_short_validator
    too_short = (start_day == end_day) && (start_hour == end_hour) && (start_minute == end_minute)
    errors.add(:end_day, "You can't define a production that lasts 0 minutes") if too_short
  end
  end
end
