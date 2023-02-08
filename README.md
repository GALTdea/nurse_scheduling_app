# README

## Nurse Scheduling App
This application demonstrates the use of the round robin algorithm to balance a nurse schedule.

It was initially started as an algorithm challenge to address the issue of balancing nurses' schedules. As development progressed, the goal evolved to include implementation of the algorithm in a Ruby on Rails application. The application is still a work in progress, but this is my current design.

## Models
* Nurse
* Shift
* Assignment
* Week
* Year


## Algorithm
The algorithm used to balanced the nurses schedule is known as the 'Round Robin' algorithm. It is a simple algorithm that takes a list of items and distributes them evenly across a number of buckets. In this case, the buckets are the shifts and the items are the nurses. The algorithm is implemented in the `Week` model.



## To Do
* Add integration tests
* Refactor algorithm to use a more efficient algorithm
