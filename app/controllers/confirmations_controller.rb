class ConfirmationsController < ApplicationController
  def update
    user = User.find(params[:id])
    user.update(active: true)
    user.save!
    flash[:notice] = "Thank you! Your account is now activated."
    redirect_to dashboard_path
  end
end
