class AddNeedsReportsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :need_report, :boolean
  end
end
