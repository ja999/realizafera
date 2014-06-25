class ProductionsController < ApplicationController
  expose(:production, attributes: :production_params)
  respond_to :json
  respond_to :html, only: [:update]

  alias_method :resource, :production

  def create
    save_resource(:created)
  end

  def update
    save_resource
    respond_to do |format|
      format.html { edit_resource }
      format.json { save_resource }
    end
  end

  def destroy
    resource.destroy
    render json: {}
  end

  private

  def save_resource(status = :ok)
    status = resource.save ? status : 422
    render json: resource, status: status
  end

  def edit_resource
    if production.update_attributes!(production_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def production_params
    params.require(:production).slice(:start_day, :start_hour, :start_minute, :end_day, :end_hour, :end_minute, :repetitive)
  end
end
