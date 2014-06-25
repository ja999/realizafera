class ProductionDecorator < Draper::Decorator
  delegate_all

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
