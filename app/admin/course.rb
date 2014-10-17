ActiveAdmin.register Course do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :name, :teacher_id, :status
  #
  # or
  #
  index do
    selectable_column
    id_column
    column :name
    column "maestro" do |c|
      link_to c.teacher.name, admin_teacher_path(c.teacher.id)
    end
    actions
  end

end
