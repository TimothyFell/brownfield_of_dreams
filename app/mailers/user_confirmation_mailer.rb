class UserConfirmationMailer < ApplicationMailer

  def confirm(user)
    @user = user
    mail(to: user.email, subject: "Account Activation")
  end
end
