class Nurse < ApplicationRecord
  has_many :assignments
  has_many :shifts, through: :assignments



  def self.balanced_schedule( nurses_per_day)
    schedule = { "Monday" => [], "Tuesday" => [], "Wednesday" => [], "Thursday" => [], "Friday" => [], "Saturday" => [], "Sunday" => [] }
    days_worked = {}
   
    last_weekend_nurse = nil

    nurses = Nurse.all.map(&:name)
    nurses.each do |nurse|
      # {"nurse0"=>0, "nurse1"=>0, "nurse2"=>0, "nurse3"=>0, "nurse4"=>0, "nurse5"=>0, "nurse6"=>0, "nurse7"=>0, "nurse8"=>0, "nurse9"=>0, "nurse10"=>0, "nurse11"=>0, "nurse12"=>0, "nurse13"=>0, "nurse14"=>0}
      days_worked[nurse] = 0
    end
    days_worked
   
    (0..6).each do |day|
      (1..nurses_per_day[day]).each do |nurse_number|
        # p (1..nurses_per_day[day])
        nurse = nil
      
        if nurse.nil? && !nurses.empty?
           nurse = nurses.shift
          #  p nurse
          #  p nurses
         if days_worked[nurse] >= 3
          nurse = nil
          # elsif last_weekend_nurse == nurse && (day == 5 || day == 6)
          # nurse = nil
         end
          schedule[Date::DAYNAMES[day]] << nurse
          last_weekend_nurse = nurse if day == 5 || day == 6
          days_worked[nurse] += 1
        end
        # the line below will add the nurse to the schedule hash, the nurse will be added to the day of the week that is being iterated. Date::DAYNAMES[day] will return the day of the week that is being iterated. e.g: Date::DAYNAMES[0] will return Monday
        # schedule[Date::DAYNAMES[day]] << nurse
        # # last_weekend_nurse = nurse if day == 5 || day == 6
        
      end
    end
    schedule
  end 

end

=begin
# NOTE: 
 Nurse.balanced_schedule([10, 10, 10, 10, 10, 10, 10])
=> {"Monday"=>["nurse10", "nurse11", "nurse12", "nurse13", "nurse14"], "Tuesday"=>[], "Wednesday"=>[], "Thursday"=>[], "Friday"=>[], "Saturday"=>[], "Sunday"=>["nurse0", "nurse1", "nurse2", "nurse3", "nurse4", "nurse5", "nurse6", "nurse7", "nurse8", "nurse9"]}

Currently, the code will not staff nurses on all days of the week. because i asked it to not staff nurses more than three days. 
the will not be enough nurses to staff all days of the week. 

challenges: 
1. modify the code so that it will staff nurses on all days. even if there's not enough nurses for the given day. 
  1. still distribute the nurses evenly every days. 
  2. return a variable indicating that there's not enough nurses to staff all days and how many nurses are needed to staff all days.

2. modify the code so that it will not prioriorize the 3 days a week rule. 

=end




