module ExerciseHelper

	def teachers_combo teachers
		options_for_select(teachers.each.map { |t| [t.name,t.id] })
	end
	def courses_combo courses
		options_for_select(courses.each.map{|c| [c.name,c.id]})
	end
	def homeworks_combo homeworks
		options_for_select(homeworks.each.map{|h| [h.name,h.id]})
	end
end
