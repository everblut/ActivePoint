ActiveAdmin.register Homework do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :course_id, :name
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
    actions
  end

end
