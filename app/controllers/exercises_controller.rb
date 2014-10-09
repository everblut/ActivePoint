class ExercisesController < ApplicationController
	def new
		@exercise = Exercise.new
		@teachers = Teacher.all
		@courses = @teachers.first.courses
		@homeworks = @courses.first.homeworks
	end

	def create
	 Exercise.do_search(exercise_params) 
	 @exercise = Exercise.new(exercise_params)
	 if @exercise.search_access(params[:exercise][:password])
	   	if @exercise.save
   		  flash[:success] = "Se ha guardado el archivo."
   		  flash[:error] = nil
      	  redirect_to root_path
      	else
      		flash.now[:error] = "Revisa los datos que estas ingresando."
      		@teachers = Teacher.all
			@courses = @teachers.first.courses
			@homeworks = @courses.first.homeworks
      		@exercise = Exercise.new
     		render 'new'
     	end
     else
      	flash.now[:error] = "El SIASE no responde a esta matricula/password"
      	@exercise = Exercise.new
      	@teachers = Teacher.all
		@courses = @teachers.first.courses
		@homeworks = @courses.first.homeworks
      	render 'new'
     end
	end

	def index
	end
	def edit
		@exercise = Exercise.find(params[:id])
	end
	def update
		@exercise = Exercise.find(params[:id])
		if @exercise.update_attributes(exercise_params)
			redirect_to root_path
		else
			render 'index'
		end
	end
	def courses_from_teacher
		@courses = Course.where(teacher_id: params[:teacher_id])
		if @courses.any?
			if @courses.first.homeworks.any?
				@homeworks = @courses.first.homeworks
			else
				@homeworks = []
			end
		else
			@homeworks = []
		end
		respond_to do |f|
			f.js
		end
	end
	def homeworks_from_course
		@homeworks = Homework.where(course_id: params[:course_id])
		respond_to do |f|  
			f.js
		end
	end

	private
 	 def exercise_params
  	  params.require(:exercise).permit(:homework_id,:name,:file,:matricula,:id)
 	 end
end
