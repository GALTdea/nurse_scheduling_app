class Year < ApplicationRecord

  has_many :weeks


   after_create :create_weeks 
  # accepts_nested_attributes_for :weeks


  # def create_shifts
    
  #   start_date = self.begining_date

  #   end_date = self.end_date
  #   (start_date..end_date).each do |date|
  #     # Shift.create(period_id: self.id, start_time: date.beginning_of_day, end_time: date.end_of_day)
  #     Shift.create!(period_id: self.id, date: date)
  #   end
    
  # end

  # def create_weeks
  #   # start_date = self.start_date

  #   # end_date = self.end_date

  #   (start_date..end_date).each do |date|
  #     # Shift.create(period_id: self.id, start_time: date.beginning_of_day, end_time: date.end_of_day)
  #     Week.create!(year_id: self.id, week_number: date)
  #   end
    
  # end

  def create_weeks
    year_object = Year.last
    year = year_object.year_date.to_i

    year = Date.new(year)

    total_weeks_in_year = year.end_of_year.cweek
    year = year.year.to_i
    (1 .. total_weeks_in_year).each do |week|
      # p week
      # p year
    p  start_date = Date.commercial(year, week).beginning_of_week
    p  end_date = Date.commercial(year, week).end_of_week

    Week.create!(year_id: year_object.id, week_number: week, start_date: start_date, end_date: end_date)
      #  p d = Date.commercial(year, week)
    end


  end




  


end
