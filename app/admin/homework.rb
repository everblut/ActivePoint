ActiveAdmin.register Homework do

  menu priority: 5

  permit_params :course_id, :name, :status, :need_report, :end_date
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
    column :end_date
    column :status
    column :need_report
    actions
  end
  form do |f|
    f.inputs do
      f.input :course
      f.input :name
      f.input :status
      f.input :need_report
      f.input :end_date, :as => :string, :input_html => {:class => "hasDatetimePicker"}
    end
    actions
  end
    action_item :only => :show do
     link_to "Crear reporte", lock_admin_homework_path(homework.id)
    end
    member_action :lock, :method => :get do
      report = Report.find(params[:id])
    end
end
