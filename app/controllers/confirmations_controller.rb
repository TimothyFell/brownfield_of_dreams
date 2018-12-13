class ConfirmationsController < ApplicationController

  def index
  end

  def update
    user = User.find(params[:id])
    user.update(active: true)
    user.save!
    redirect_to confirmed_path
  end
end
