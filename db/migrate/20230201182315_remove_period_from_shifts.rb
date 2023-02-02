class RemovePeriodFromShifts < ActiveRecord::Migration[7.0]
  def change
    remove_reference :shifts, :period, null: false, foreign_key: true
  end
end
