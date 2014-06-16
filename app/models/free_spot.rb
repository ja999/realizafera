class FreeSpot < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user
  validate :start_day, :end_day,       inclusion: { in: (0..6)  }
  validate :start_hour, :end_hour,     inclusion: { in: (0..23) }
  validate :start_minute, :end_minute, inclusion: { in: (0..59) }

  attr_accessible :start_day, :end_day,
:start_hour, :end_hour,
:start_minute, :end_minute

  DAYS = {
    'poniedziałek' => '0',
    'wtorek' => '1',
    'środa' => '2',
    'czwartek' => '3',
    'piątek' => '4',
    'sobota' => '5',
    'niedziela' => '6',
  }
end
