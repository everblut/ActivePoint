class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name
      t.integer :homework_id

      t.timestamps
    end
  end
end
