class FreeSpotDecorator < Draper::Decorator
  delegate_all

  DAYS = ['poniedziałek', 'wtorek', 'środa', 'czwartek', 'piątek', 'sobota', 'niedziela']

  def start_date
    day = DAYS.fetch(model.start_day).capitalize
    hours = ", od #{time_format(model.start_hour)}:#{time_format(model.start_minute)}"
    day + hours
  end

  def end_date
    day = DAYS.fetch(model.end_day).capitalize
    hours = ", do #{time_format(model.end_hour)}:#{time_format(model.end_minute)}"
    day + hours
  end

  def time_format value
    if value < 10
      '0' + value.to_s
    else
      value.to_s
    end
  end
end
