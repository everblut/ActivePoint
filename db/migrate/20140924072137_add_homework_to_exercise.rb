class AddHomeworkToExercise < ActiveRecord::Migration
  def change
  	remove_column :exercises, :course_id
    add_column :exercises, :homework_id, :integer
  end
end
