class HomeController < ApplicationController
  expose(:productions) { Production.all }

  def index
  end
end
