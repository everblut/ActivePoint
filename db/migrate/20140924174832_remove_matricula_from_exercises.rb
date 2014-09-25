class RemoveMatriculaFromExercises < ActiveRecord::Migration
  def change
    	remove_column :exercises, :matricula
  end
end
