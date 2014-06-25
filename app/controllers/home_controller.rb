class HomeController < ApplicationController
  expose(:productions) { Production.all.decorate.sort_by { |p| [p.start_day, p.start_hour, p.start_minute] } }

  def index
  end
end
