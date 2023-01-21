class CreateShifts < ActiveRecord::Migration[7.0]
  def change
    create_table :shifts do |t|
      t.string :name
      t.string :date
      t.references :period, null: false, foreign_key: true
      t.timestamps
    end
  end
end
