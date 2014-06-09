class ProductionsController < ApplicationController
  expose(:production, attributes: :production_params)
  respond_to :json

  def create

  end

  private

  def production_params
    params.require(:production).slice(:start_day, :start_hour, :end_day, :end_hour, :repetitive)
  end
end
