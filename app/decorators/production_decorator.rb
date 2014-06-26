class ProductionDecorator < Draper::Decorator
  delegate_all

  decorates_association :user

  def start_date
    day = Production::DAYS.fetch(model.start_day).capitalize
    hours = ", od #{time_format(model.start_hour)}:#{time_format(model.start_minute)}"
    day + hours
  end

  def end_date
    day = Production::DAYS.fetch(model.end_day).capitalize
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

  [:start_hour, :start_minute, :end_hour, :end_minute].each do |type|
    define_method "#{type}" do
      if object.send("#{type}") < 10
        '0' + object.send("#{type}").to_s
      else
        object.send("#{type}").to_s
      end
    end
  end
end
