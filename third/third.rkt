#lang racket

;Structures, like lists, are yet another means of packaging multiple pieces of data together
;in Racket. While lists are good for grouping an arbitrary number of items, structures
;are good for combining a fixed number of items. Say, for example, we need to track the
;name, student ID number, and dorm room number of every student on campus. In this
;case, we should use a structure to represent a student’s information because each student
;has a fixed number of attributes: name, ID, and dorm. However, we would want to use a
;list to represent all of the students, since the campus has an arbitrary number of students,
;which may grow and shrink.

;define a struct student
(struct student (name id# dorm))

(define freshman1 (student 'Joe 1234 'NewHall))
(student-name freshman1)
(student-id# freshman1)
(student-dorm freshman1)

;Data can be stored as a list of structures
(define mimi (student 'Mimi 234 'NewHall))
(define nicole (student 'Nicole 2334 'NewHall))
(define rose (student 'Rose 2345 'NewHall))
(define eric (student 'Eric 27834 'NewHall))
;Define a list of students
(define in-class(list mimi nicole rose eric))

(student-name (third in-class))

;Nested structures and lists
(struct student-body (freshmen sophmores juniors seniors)) 
(define all-students 
           (student-body (list freshman1 (student 'Mary 0101 'OldHall))
                         (list (student 'Jeff 5678 'OldHall) (student 'Suvy 1678 'OldHall))
			 (list (student 'Bob 4321 'Apartment))
 			empty))


;Ask questions
;who is the first freshman in the within all-students
(student-name (first (student-body-freshmen all-students)))
(student-name (second (student-body-freshmen all-students)))
(student-name (second (student-body-sophmores all-students)))
