class Production < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user

  validates :start_day,                 inclusion: { in: (0..6)  }
  validates :end_day,                   inclusion: { in: (0..7)  }
  validates :start_hour, :end_hour,     inclusion: { in: (0..23) }
  validates :start_minute, :end_minute, inclusion: { in: (0..59) }

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
    where("
       (start_day <= end_day AND start_day <= ? AND ? <= end_day)
    OR (start_day > end_day AND (start_day <= ? OR ? <= end_day))
    ", wday, wday, wday, wday)

  private

  def check_end_day
    self.end_day += 7 if self.start_day > self.end_day
  end
  end
end
