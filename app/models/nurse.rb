class Nurse < ApplicationRecord
  has_many :assignments
  has_many :shifts, through: :assignments
  @nurses = Nurse.all
  @total_nurses = @nurses.count

  def self.nurses_needed( nurses_per_day)
    @total_assignments_needed = nurses_per_day.sum
    @total_assignments_available = @total_nurses * 3
   
    if  @total_assignments_available >= @total_assignments_needed
      3
    elsif @total_assignments_needed > @total_assignments_available
      p "#{ (@total_assignments_needed - @total_nurses) * 12 } hours needed of overtime"
       ((((@total_assignments_needed)/3.0).ceil).to_f / @total_nurses).ceil + 3
    end
  end

  def self.balanced_schedule( nurses_per_day)
    schedule = { "Monday" => [], "Tuesday" => [], "Wednesday" => [], "Thursday" => [], "Friday" => [], "Saturday" => [], "Sunday" => [] }
    days_worked = {}
    @shifts_per_nurse_needed = self.nurses_needed( [10, 10, 10, 10, 10, 10, 10])

    last_weekend_nurse = nil

    nurses = Nurse.all.map(&:name)

    nurses.each do |nurse|
      days_worked[nurse] = 0
      # {"nurse0"=>0, "nurse1"=>0, "nurse2"=>0, "nurse3"=>0, "nurse4"=>0, "nurse5"=>0, "nurse6"=>0, "nurse7"=>0, "nurse8"=>0, "nurse9"=>0, "nurse10"=>0, "nurse11"=>0, "nurse12"=>0, "nurse13"=>0, "nurse14"=>0}
    end
    days_worked

    (0..6).each do |day|
      "#{schedule[Date::DAYNAMES[day]]} iteration"
      (1..nurses_per_day[day]).each do |nurse_number|

        nurse = nil
        if nurse.nil? 
          nurse = nurses.shift
          if nurses.empty?
            nurses = Nurse.all.reverse.map(&:name)
          end
          if days_worked[nurse] >= @shifts_per_nurse_needed
            nurse = nil
          end
          schedule[Date::DAYNAMES[day]] << nurse
          days_worked[nurse] += 1
        end
      end
    end
 
    nurses_schedule = {}
    

    @nurses.map(&:name).each do |nurse|
      nurse
     nurses_schedule[nurse] = []
    end
    p '-----------------'
    p '-----------------'
    p '-----------------'
    @nurses.map(&:name).each do |nurse|
      schedule.each do |day, nurses|
        if nurses.include?(nurse)
          nurses_schedule[nurse] << day
        end
      end
      p "#{nurse} is scheduled to work #{nurses_schedule[nurse].count} days: #{nurses_schedule[nurse].join(', ')}"
    end

    p '-----------------'
    p '-----------------'
    p '-----------------'
     schedule.each do |day, nurses|
      p "#{day}: #{nurses.count} nurses scheduled: #{nurses.join(', ')}"
    end
  end
end

=begin
NOTE: 1/25
 Nurse.balanced_schedule([10, 10, 10, 10, 10, 10, 10])
  - added nurse_schedule method to return a hash of nurses and the days they are scheduled to work

  - fixed issues where method wasn't covering all days. 
  - added a method to calculate the number of nurses needed to staff all days.

  - returning
  {
  "Monday"=>["nurse10", "nurse11", "nurse12", "nurse13", "nurse14", "nurse14", "nurse13", "nurse12", "nurse11", "nurse10"],
  "Tuesday"=>["nurse9", "nurse8", "nurse7", "nurse6", "nurse5", "nurse4", "nurse3", "nurse2", "nurse1", "nurse0"],
  "Wednesday"=>["nurse14", "nurse13", "nurse12", "nurse11", "nurse10", "nurse9", "nurse8", "nurse7", "nurse6", "nurse5"],
  "Thursday"=>["nurse4", "nurse3", "nurse2", "nurse1", "nurse0", "nurse14", "nurse13", "nurse12", "nurse11", "nurse10"],
  "Friday"=>["nurse9", "nurse8", "nurse7", "nurse6", "nurse5", "nurse4", "nurse3", "nurse2", "nurse1", "nurse0"],
  "Saturday"=>["nurse14", "nurse13", "nurse12", "nurse11", "nurse10", "nurse9", "nurse8", "nurse7", "nurse6", "nurse5"],
  "Sunday"=>["nurse0", "nurse1", "nurse2", "nurse3", "nurse4", "nurse5", "nurse6", "nurse7", "nurse8", "nurse9"]}


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


  => {
      "Monday"=>["nurse10", "nurse11", "nurse12", "nurse13", "nurse14"],
      "Tuesday"=>[],
      "Wednesday"=>[],
      "Thursday"=>[],
      "Friday"=>[],
      "Saturday"=>[],
      "Sunday"=>["nurse0", "nurse1", "nurse2", "nurse3", "nurse4", "nurse5", "nurse6", "nurse7", "nurse8", "nurse9"]}
=end
