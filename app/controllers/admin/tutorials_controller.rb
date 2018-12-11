class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial_params[:tag_list]
      tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    elsif classroom_params[:classroom]
      tutorial.update(classroom_params)
      flash[:success] = "#{tutorial.title} classroom status updated!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  private
  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def classroom_params
    params.require(:tutorial).permit(:classroom)
  end
end
