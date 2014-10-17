class AddStatusToHomeworks < ActiveRecord::Migration
  def change
  	add_column :homeworks, :status, :boolean, default: true
  end
end
