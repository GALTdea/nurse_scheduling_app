class CreatePeriods < ActiveRecord::Migration[7.0]
  def change
    create_table :periods do |t|
      t.string :name
      t.string :number
      t.date :begining_date
      t.date :end_date

      t.timestamps
    end
  end
end
