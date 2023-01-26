class Shift < ApplicationRecord
  belongs_to :period
  has_many :assignments
  has_many :nurses, through: :assignments
  accepts_nested_attributes_for :assignments


  def unassigned_nurses
    Nurse.all - self.nurses
  end
end