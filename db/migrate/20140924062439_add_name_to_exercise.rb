class AddNameToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :name, :string
  end
end
