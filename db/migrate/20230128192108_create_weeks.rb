class CreateWeeks < ActiveRecord::Migration[7.0]
  def change
    create_table :weeks do |t|
      t.integer :week_number
      t.date :start_date
      t.date :end_date
      t.references :year, null: false, foreign_key: true

      t.timestamps
    end
  end
end
