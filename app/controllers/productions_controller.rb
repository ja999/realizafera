class ProductionsController < ApplicationController
  expose(:production, attributes: :production_params)
  expose_decorated(:user_productions, decorator: ProductionDecorator) {
    Production.where('user_id = :curr_user AND cancelled = false', curr_user: current_user)
  }
  expose_decorated(:cancelled_user_productions, decorator: ProductionDecorator) {
    Production.where('user_id = :curr_user AND cancelled = true', curr_user: current_user)
  }

  respond_to :json
  respond_to :html, only: [:update, :my_productions, :user_annulments]

  alias_method :resource, :production

  def create
    save_resource(:created)
  end

  def update
    respond_to do |format|
      format.html { edit_resource }
      format.json { save_resource }
    end
  end

  def destroy
    resource.destroy
    render json: {}
  end

  def my_productions
  end

  def user_annulments
  end

  def cancel
    production.update_attribute(:cancelled, true)
    redirect_to user_annulments_path
  end

  def claim
    production.update_attributes(cancelled: false, user_id: current_user.id)
    redirect_to my_productions_path
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
    params.require(:production).slice(:start_day, :start_hour, :start_minute, :end_day, :end_hour, :end_minute, :repetitive, :cancelled, :user_id)
  end
end
