module ExerciseHelper

	def teachers_combo teachers
		return nil if teachers.nil?
		options_for_select(teachers.each.map { |t| [t.name,t.id] })
	end
	def courses_combo courses
		return nil if courses.nil?
		options_for_select(courses.each.map{|c| [c.name,c.id]})
	end
	def homeworks_combo homeworks
		return nil if homeworks.nil?
		options_for_select(homeworks.each.map{|h| [h.name,h.id]})
	end
end
