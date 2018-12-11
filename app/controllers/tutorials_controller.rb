class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if logged_in && tutorial.classroom == true
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    elsif tutorial.classroom == false
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    else
      flash[:notice] = 'You are not authorized to view that tutorial. Please Signup or Login to gain access.'
      redirect_to root_path
    end
  end
end
