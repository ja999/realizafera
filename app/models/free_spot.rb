class FreeSpot < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user

  validates :user_id, presence: true
  validates :start_day, :end_day,       inclusion: { in: (0..6)  }
  validates :start_hour, :end_hour,     inclusion: { in: (0..23) }
  validates :start_minute, :end_minute, inclusion: { in: (0..59) }

  attr_accessible :start_day,
                  :end_day,
                  :start_hour,
                  :end_hour,
                  :start_minute,
                  :end_minute

  DAYS = {
    'niedziela' => '0',
    'poniedziałek' => '1',
    'wtorek' => '2',
    'środa' => '3',
    'czwartek' => '4',
    'piątek' => '5',
    'sobota' => '6',
  }

  def self.available_people dstart, dend, hstart, hend, current_user_id
    available_users = []
    available_users << self.where('
      start_day <= :wday_start AND
      :wday_end <= end_day AND
      start_hour <= :hour_start AND
      :hour_end <= end_hour AND
      user_id != :user',
      wday_start: dstart,
      wday_end: dend,
      hour_start: hstart,
      hour_end: hend,
      user: current_user_id
    ).map(&:user)
    available_users << self.where('
      end_day < start_day AND
      :wday_end <= end_day AND
      :hour_end <= end_hour AND
      user_id != :user',
      wday_start: dstart,
      wday_end: dend,
      hour_start: hstart,
      hour_end: hend,
      user: current_user_id
    ).map(&:user)
    available_users
  end

  def self.enough_for production
    startDayDiff = (production.start_day + 7 - Time.now.wday) % 7
    startHourDiff = 24 * startDayDiff + production.start_hour - Time.now.hour
    startMinuteDiff = 60 * startHourDiff + production.start_minute - Time.now.min

    endDayDiff = (production.end_day + 7 - Time.now.wday) % 7
    endHourDiff = 24 * endDayDiff + production.end_hour - Time.now.hour
    endMinuteDiff = 60 * endHourDiff + production.end_minute - Time.now.min

    startDayDiffFree = (self.start_day + 7 - Time.now.wday) % 7
    startHourDiffFree = 24 * startDayDiffFree + self.start_hour - Time.now.hour
    startMinuteDiffFree = 60 * startHourDiffFree + self.start_minute - Time.now.min

    endDayDiffFree = (self.end_day + 7 - Time.now.wday) % 7
    endHourDiffFree = 24 * endDayDiffFree + self.end_hour - Time.now.hour
    endMinuteDiffFree = 60 * endHourDiffFree + self.end_minute - Time.now.min

    if startMinuteDiffFree <= startMinuteDiff && endMinuteDiff <= endMinuteDiffFree
      return true
    else
      return false
    end
  end
end
