class Production < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user

  validates :start_day,                 inclusion: { in: (0..6)  }
  validates :end_day,                   inclusion: { in: (0..7)  }
  validates :start_hour, :end_hour,     inclusion: { in: (0..23) }
  validates :start_minute, :end_minute, inclusion: { in: (0..59) }

  validate :too_long_validator
  validate :too_short_validator
  validate :overlapping_validator
  validate :negative_time_validator

  before_validation :check_end_day

  scope :assigned, -> { where.not(user_id: nil) }
  scope :not_assigned, -> { where(user_id: nil) }

  attr_accessible :start_day,
                  :start_hour,
                  :start_minute,
                  :end_day,
                  :end_hour,
                  :end_minute,
                  :repetitive,
                  :cancelled,
                  :user_id

  DAYS = ['niedziela', 'poniedziałek', 'wtorek', 'środa', 'czwartek', 'piątek', 'sobota']

  def self.incident_with_wday(wday)
    where('start_day <= ? AND ? <= end_day', wday, wday)
  end

  def in_progress
    if (start_day == end_day)
      if Time.now.wday == start_day && Time.now.hour > start_hour && Time.now.hour < end_hour
        return true
      else
        return false
      end
    else
      if (Time.now.wday == start_day && Time.now.hour > start_hour) || (Time.now.hour < end_hour)
        return true
      else
        return false
      end
    end
  end

  def self.clean_ongoing_productions
    # This method is regularly called by cron
    Production.all.each do |prod|
      if prod.repetitive && prod.in_progress
        prod.update_attribute(:reminded, false)
      end
    end
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

  def negative_time_validator
    negative_time = (start_day == end_day) && (start_hour > end_hour)
    negative_time ||= (start_day == end_day) && (start_hour == end_hour) && (start_minute > end_minute)
    errors.add(:end_day, "You can't define a production has less than 0 minutes") if negative_time
  end

  def overlapping_validator
    no_overlapping_productions = self.class.where("start_day <= ? AND (start_hour * 60 + start_minute < ?)"\
      "AND end_day >= ? AND (end_hour * 60 + end_minute > ?)", end_day, end_hour * 60 + end_minute,
                                                                start_day, start_hour * 60 + start_minute)
    no_overlapping_productions = no_overlapping_productions.where('id != ?', id) if id.present?
    no_overlapping_productions = no_overlapping_productions.count
    errors.add(:start_day, 'This production overlaps with another one') unless no_overlapping_productions.zero?
  end
end
