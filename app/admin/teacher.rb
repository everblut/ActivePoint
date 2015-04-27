ActiveAdmin.register Teacher do

  menu priority: 3
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name
  #
  # or
  #
   index do
    selectable_column
    id_column
    column :name
    actions
  end


end
