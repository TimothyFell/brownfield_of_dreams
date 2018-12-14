class InvitationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.invite.subject
  #
  def invite(user, invitee_data, host)
    @host = host
    @user = user
    @invitee_data = invitee_data
    mail(to: invitee_data[:email], subject: "#{invitee_data[:login]}, You've Been Invited to Brownfield of Dreams!")
  end
end
