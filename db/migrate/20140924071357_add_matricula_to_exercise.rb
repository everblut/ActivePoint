class AddMatriculaToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :matricula, :string
  end
end
