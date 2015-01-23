class AddEndDateToHomework < ActiveRecord::Migration
  def change
    add_column :homeworks, :end_date, :datetime
  end
end
