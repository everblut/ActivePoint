class HomeworksController < ApplicationController
  def index
  	@homeworks = Homework.all
  end

  def show
  	@homework = Homework.find(params[:id])
  end
end
