class AddFileToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :file, :string
  end
end
