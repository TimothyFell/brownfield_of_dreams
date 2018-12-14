class UsersController < ApplicationController
  def show
    @user_dashboard_facade = UserDashboardFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      host = request.env["HTTP_HOST"]
      UserConfirmationMailer.confirm(user, host).deliver_now
      flash[:success] = "Logged in as #{user.name}"
      flash[:confirm] = "This account has not yet been activated. Please check your email."
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    user = User.find(current_user.id)
    user.token = "token #{request.env['omniauth.auth']["credentials"]["token"]}"
    user.guid =  request.env['omniauth.auth']["uid"]
    user.github_name = request.env['omniauth.auth']['name']
    user.save!
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
