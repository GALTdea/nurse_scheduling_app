# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

nurses = 150.times.map do |i|
  Nurse.create(name: "nurse#{i}", time: i)
end

# periods = 12.times.map do |i|
#   #  for the next periods, i want to create them with begining_dates to be the end_date of the previous period
#   #  and end_dates to be the begining_date of the next period. to do that i need to create the periods in reverse order like this:after =>  column_name: Date.today + (i + 1).months, before => column_name: Date.today + i.months

#   Period.create!(name: "#{i}", begining_date: Date.today, end_date: Date.today + (i + 1).months)
#   # p "period #{i} created with begining_date: #{Date.today + (i + 1).months} and end_date: #{Date.today + (i + 1).months}"
# end
p ' -----------------'


