
class Week < ApplicationRecord
  belongs_to :year

  has_many :shifts
  accepts_nested_attributes_for :shifts

  # after_create :create_shifts

  @nurses = Nurse.all
  @total_nurses = @nurses.count
  

  #  @@schedule = { "Monday" => [], "Tuesday" => [], "Wednesday" => [], "Thursday" => [], "Friday" => [], "Saturday" => [], "Sunday" => [] }



  def self.create_shifts(w)
    days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    (0..6).each do |day|
      Shift.create!(week_id: w.id, name: days[day])
    end
  end

  
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

#  to create a method that iterates through the week shifts and returns a hash of the shifts and the nurses assigned to them, 
# first we need to create a hash of the shifts and the nurses assigned to them
# second we need to iterate through the hash and return the nurses assigned to each shift

  def self.create_shifts_nurses_hash(week)
    # p week
    shift_hash = {}
    shifts = week.shifts

    shifts.each do |shift|
      shift_hash[shift.id] = shift.nurses.pluck(:name)
    end
    shift_hash
  end

  def self.nurse_days_worked(week)
    schedule = self.create_shifts_nurses_hash(week)
    days_worked = {}
    
     @nurses.each do |nurse|
      total = 0
     
      schedule.each do |shift, nurses|
        if nurses.include?(nurse.name)
          total += 1
        end
      end
      days_worked[nurse.name] = total
    end
    days_worked
  end
  
  def self.balance_schedule(w)
    nurses_per_day = [10, 10, 10, 10, 10, 10, 10]
    #  schedule = { "Monday" => [], "Tuesday" => [], "Wednesday" => [], "Thursday" => [], "Friday" => [], "Saturday" => [], "Sunday" => [] }
    days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    schedule = self.create_shifts_nurses_hash(w)
    # p schedule.values
    days_worked = self.nurse_days_worked(w)
    @shifts_per_nurse_needed = self.nurses_needed( [10, 10, 10, 10, 10, 10, 10])

    last_weekend_nurse = nil

     nurses = Nurse.all.map(&:name)

    # nurses.each do |nurse|
    #   days_worked[nurse] = 0
    #   # returns a hash of the nurses and the number of days they have worked i.e {}
    #   # will return this = { "Nurse 1" => 0, "Nurse 2" => 0, "Nurse 3" => 0, "Nurse 4" => 0, "Nurse 5" => 0, "Nurse 6" => 0, "Nurse 7" => 0, "Nurse 8" => 0, "Nurse 9" => 0, "Nurse 10" => 0, "Nurse 11" => 0, "Nurse 12" => 0, "Nurse 13" => 0, "Nurse 14" => 0, "Nurse 15" => 0, "Nurse 16" => 0, "Nurse 17" => 0, "Nurse 18" => 0, "Nurse 19" => 0, "Nurse 20" => 0, "Nurse 21" => 0, "Nurse 22" => 0, "Nurse 23" => 0, "Nurse 24" => 0, "Nurse 25" => 0, "Nurse 26" => 0, "Nurse 27" => 0, "Nurse 28" => 0, "Nurse 29" => 0, "Nurse 30" => 0, "Nurse 31" => 0, "Nurse 32" => 0, "Nurse 33" => 0, "Nurse 34" => 0, "Nurse 35" => 0, "Nurse 36" => 0, "Nurse 37" => 0, "Nurse 38" => 0, "Nurse 39" => 0, "Nurse 40" => 0, "Nurse 41" => 0, "Nurse 42" => 0, "Nurse 43" => 0, "Nurse 44" => 0, "Nurse 45" => 0, "Nurse 46" => 0, "Nurse 47" => 0, "Nurse 48" => 0, "Nurse 49" => 0, "Nurse 50" => 0}
    # end

    (0..6).each do |day|
      # p day
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
          # p schedule.keys[day]
          schedule[schedule.keys[day]] << nurse
          shift_id = Shift.find_by(id: schedule.keys[day]).id
          # p nurse
          nurse_id = Nurse.find_by(name: nurse).id
          # p schedule
        #  p shift_id = Shift.find_by(name: schedule.keys[day])

          Assignment.create!(shift_id: shift_id, nurse_id: nurse_id  )

          # schedule[schedule.keys[day]] << nurse
          # schedule[Date::DAYNAMES[day]] << nurse
          # p schedule[day]
          # p schedule[Date::DAYNAMES[day]]
         

          # {20=>["nurse0"], 21=>[], 22=>[], 23=>[], 24=>[], 25=>[], 26=>[]}
          # schedule[day] << nurse
          # p schedule[day]
          # Assignment.create!( shift_id: Shift.find_by(name: Date::DAYNAMES[day]).id, nurse_id: Nurse.find_by(name: nurse).id)
          # Assignment.create!( shift_id: Shift.find_by(id:   )  )
          # instead of adding nurse to schedule, create a new assignment for the nurse and the shift

          days_worked[nurse] += 1
        end
      end
    end
 

    # Week.shifts.each do |shift|
    #   p shift.nurses
    # end
    p '-----------------'
    # @@schedule
    schedule
  end









  # def self.assignments_info
  #   period = Period.last
  #    assignments = period.shifts

  #   assignments.each do |a|
  #     p a.nurses
  #   end
  # end
end


=begin
w = Week.find()
Week.balance_schedule(w, [10, 10, 10, 10, 10, 10, 10])
=end