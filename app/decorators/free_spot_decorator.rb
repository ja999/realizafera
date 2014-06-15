class FreeSpotDecorator < Draper::Decorator
  delegate_all

  DAYS = ['poniedziałek', 'wtorek', 'środa', 'czwartek', 'piątek', 'sobota', 'niedziela']

  def start_date
    day = DAYS.fetch(model.start_day).capitalize
    hours = ", od #{model.start_hour}:#{model.start_minute}"
    day + hours
  end

  def end_date
    day = DAYS.fetch(model.end_day).capitalize
    hours = ", do #{model.end_hour}:#{model.end_minute}"
    day + hours
  end
end
