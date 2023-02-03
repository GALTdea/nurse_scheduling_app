class Assignment < ApplicationRecord
  belongs_to :nurse
  belongs_to :shift


  def unassigned_nurses
    Nurse.all.where.not(id: self.nurses.ids)
  end
  # def unassigned_nurses(join_table, association)
  #   # Get the ids of the objects already included in the join table
  #   included_ids = join_table.pluck(association).map(&:id)
  
  #   # Use the 'where.not' method to filter out objects with those ids
  #   objects = association.class.where.not(id: included_ids)
  # end
end
