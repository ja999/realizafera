class ProductionsController < ApplicationController
  expose(:production, attributes: :production_params)
  expose_decorated(:user_productions, decorator: ProductionDecorator) {
    Production.where('user_id = :curr_user AND cancelled = false', curr_user: current_user)
  }
  expose_decorated(:cancelled_user_productions, decorator: ProductionDecorator) {
    Production.where('user_id = :curr_user AND cancelled = true', curr_user: current_user)
  }
  expose_decorated(:cancelled_productions, decorator: ProductionDecorator) {
    Production.where(cancelled: true)
  }
  expose_decorated(:free_productions, decorator: ProductionDecorator) {
    Production.not_assigned
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

  def my_productions; end

  def user_annulments; end

  def exchange; end

  def available_productions; end

  def cancel
    flash[:notice] = 'Anulowano realizacje. ...a może jednak dasz radę się pojawić? :)'
    free_users = FreeSpot.available_people(
      production.start_day,
      production.end_day,
      production.start_hour,
      production.end_hour,
      current_user.id
    )
    production.update_attribute(:cancelled, true)
    ProductionMailer.send_production_opening current_user, free_users, production
    redirect_to user_annulments_path
  end

  def claim
    if production.user_id == current_user.id
      flash[:error] = 'Przejąłeś swoją własną realizacje... Na pewno o to Ci chodziło? o_O'
    end
    if production.update_attributes(cancelled: false, user_id: current_user.id)
      flash[:success] = 'Przejąłeś realizację! :) Dzięki za pomoc!'
    else
      flash[:error] = 'Coś poszło bardzo nie tak... Jeśli realizacja nie pojawiła się w Twoim profilu skontaktuj się z Szefem Studia Emisyjnego, by zrobił to ręcznie.'
    end
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
