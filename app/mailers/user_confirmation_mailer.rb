class UserConfirmationMailer < ApplicationMailer

  def confirm(user, host)
    @user = user
    @host = host
    mail(to: user.email, subject: "Account Activation")
  end
end
