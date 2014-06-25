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
end
