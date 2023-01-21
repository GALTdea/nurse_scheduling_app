class Shift < ApplicationRecord
  belongs_to :period
  has_many :assignments
  has_many :nurses, through: :assignments
  accepts_nested_attributes_for :assignments


  def unassigned_nurses
    Nurse.all - self.nurses
  end

  # def create_shifts
  #   start_date = self.begining_date
  #   end_date = self.end_date
  #   (start_date..end_date).each do |date|
  #     # Shift.create(period_id: self.id, start_time: date.beginning_of_day, end_time: date.end_of_day)
  #     Shift.create!(period_id: self.id, date: date)
  #   end
    
  # end

end