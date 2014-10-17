class ExercisesController < ApplicationController
	def new
		set_combos
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
      		set_combos
     	end
     else
      	flash.now[:error] = "El SIASE no responde a esta matricula/password"
      	set_combos
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
		@courses = Course.active_with_teacher(params[:teacher_id])
		if @courses.any?
			if @courses.first.homeworks.any?
				@homeworks = @courses.first.homeworks.active
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
		@homeworks = Homework.active_with_course(params[:course_id])
		respond_to do |f|  
			f.js
		end
	end

	private
 	 def exercise_params
  	  params.require(:exercise).permit(:homework_id,:name,:file,:matricula,:id)
 	 end
 	 def set_combos
		@teachers = Teacher.all
		@courses = @teachers.first.courses.active
		@homeworks = @courses.first.homeworks.active
		@exercise = Exercise.new
		render 'new'
	end
end
