ActiveAdmin.register Exercise do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :homework_id,:name,:file
  #
  # or
  #
  index do
    selectable_column
    id_column
    column :name
    column :file
    column "tarea" do |c|
      link_to c.homework.name, admin_homework_path(c.homework.id)
    end
    column "curso" do |c|
      link_to c.homework.course.name, admin_course_path(c.homework.course.id)
    end
    column "maestro" do |c|
      link_to c.homework.course.teacher.name, admin_teacher_path(c.homework.course.teacher.id)
    end
    actions
  end


end
