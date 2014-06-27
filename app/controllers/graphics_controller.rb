class GraphicsController < ApplicationController
  respond_to :json
  expose(:graphic) { Graphic.new(permitted_attributes) }

  before_filter :authenticate_admin_user!

  def show
    render json: graphic, serializer: GraphicSerializer
  end

  private

  def permitted_attributes
    date_hash = params.permit(:date)
  end
end
