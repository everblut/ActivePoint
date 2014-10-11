module ExerciseHelper

	def teachers_combo teachers
		return teachers.nil? ? nil : create_combo(teachers) 
	end
	def courses_combo courses
		return courses.nil? ? nil : create_combo(courses)
	end
	def homeworks_combo homeworks
		return homeworks.nil? ? nil : create_combo(homeworks)
	end
	def create_combo items
		options_for_select(items.each.map{|i| [i.name,i.id]})
	end
end
