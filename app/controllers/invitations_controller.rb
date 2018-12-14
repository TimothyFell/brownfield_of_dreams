class InvitationsController < ApplicationController

  def new

  end

  def create

    invitee_data = InviteService.new(invite_params[:handle], current_user.token).get_user_json

    if invitee_data[:email]
      host = request.env["HTTP_HOST"]
      InvitationMailer.invite(current_user, invitee_data, host).deliver_now
      flash[:sucess] = "Successfully sent invite!"
    else
      flash[:faiil] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end

  private

  def invite_params
    params.permit(:handle)
  end


end
