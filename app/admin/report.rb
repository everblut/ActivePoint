ActiveAdmin.register Report do

 menu priority: 2, label: "report"
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :homework_id,:name
  #
  # or
  #
  index do
    selectable_column
    id_column
    column :name do |c|
      c.short_name
    end
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


    show :title => :short_name do 
      attributes_table do
        row :short_name
        row :homework_id do |c|
         link_to c.homework.name, admin_homework_path(c.homework.id)
        end 
        row :created_at
        row :updated_at
      end
    end

    controller do
      # This code is evaluated within the controller class

      def lock
        render 'show'
      end
    end

end
