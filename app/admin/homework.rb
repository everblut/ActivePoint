ActiveAdmin.register Homework do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :course_id, :name, :status, :need_report
  #
  # or
  #
  index do
    selectable_column
    id_column
    column :name
    column "curso" do |c|
      link_to c.course.name, admin_course_path(c.course.id)
    end
    column "maestro" do |m|
      link_to m.course.teacher.name, admin_teacher_path(m.course.teacher.id)
    end
    column :status
    column :need_report
    actions
  end

    action_item :only => :show do
     link_to "Crear reporte", lock_admin_homework_path(homework.id)
    end
    member_action :lock, :method => :get do
      report = Report.find(params[:id])
    end
end
