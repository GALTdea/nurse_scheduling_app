class Period < ApplicationRecord
  has_many :shifts
  accepts_nested_attributes_for :shifts

  after_create :create_shifts


  def create_shifts
    start_date = self.begining_date
    end_date = self.end_date
    (start_date..end_date).each do |date|
      # Shift.create(period_id: self.id, start_time: date.beginning_of_day, end_time: date.end_of_day)
      Shift.create!(period_id: self.id, date: date)
    end
    
  end
end
