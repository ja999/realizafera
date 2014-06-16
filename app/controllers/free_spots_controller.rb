class FreeSpotsController < ApplicationController
  expose_decorated :free_spot
  expose_decorated :free_spots

  def index
  end

  def new; end

  def create
    free_spot.user = current_user
    if free_spot.update_attributes!(free_spot_params)
      redirect_to free_spots_path
    else
      render :new
    end
  end

  def update
    if free_spot.update_attributes!(free_spot_params)
      redirect_to free_spots_path
    else
      render :edit
    end
  end

  private

  def free_spot_params
    params.require(:free_spot).permit(
      :start_day,
      :start_hour,
      :end_day,
      :end_hour,
      :start_minute,
      :end_minute,
      :user_id
    )
  end
end
