class AddReportFlagToHomework < ActiveRecord::Migration
  def change
  	add_column :homeworks, :need_report, :boolean, status: false
  end
end
