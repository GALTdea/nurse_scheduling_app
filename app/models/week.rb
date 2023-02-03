
class Week < ApplicationRecord
  belongs_to :year

  has_many :shifts, dependent: :destroy
  accepts_nested_attributes_for :shifts

  #after_create :create_shifts

  @nurses = Nurse.all
  @total_nurses = @nurses.count
  
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

  def self.create_shifts_nurses_hash(week)
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
    days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    schedule = self.create_shifts_nurses_hash(w)
    days_worked = self.nurse_days_worked(w)
    @shifts_per_nurse_needed = self.nurses_needed( [10, 10, 10, 10, 10, 10, 10])

    last_weekend_nurse = nil

     nurses = Nurse.all.map(&:name)

    (0..6).each do |day|
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

          schedule[schedule.keys[day]] << nurse

          shift_id = Shift.find_by(id: schedule.keys[day]).id
          nurse_id = Nurse.find_by(name: nurse).id
          Assignment.create!(shift_id: shift_id, nurse_id: nurse_id  )
          days_worked[nurse] += 1
        end
      end
    end
    schedule
  end
end