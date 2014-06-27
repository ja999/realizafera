class ChiefController < ApplicationController
  before_filter :authenticate_admin_user!

  def graphic
  end
end
