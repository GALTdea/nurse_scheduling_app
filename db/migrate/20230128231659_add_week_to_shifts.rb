class AddWeekToShifts < ActiveRecord::Migration[7.0]
  def change
    add_reference :shifts, :week, null: false, foreign_key: true
  end
end
