#lang racket

; Wizard Adventure Game - see Land of Lisp 

;define all the locations in an alist (associative list), descriptions are defined as 'symbols' rather than strings)
(define *nodes* '((living-room (you are in the living room, a wizard is snoring loudly in the couch))
                  (garden (you are in a beautiful garden, there is a well in front of you.))
                  (attic (you are in the attic, there is a giant weilding torch in the corner.))))

;retrive the description associated with a particular key within the associative list called *nodes*
(define (describe-location location nodes)
  (cadr (assoc location *nodes*)))

;Describe all the edges/paths from each one of the above locations
(define *edges* '((living-room (garden west door) 
                               (attic upstairs ladder))
                  (garden (living-room east door))
                  (attic (living-room downstairs ladder)))) 
;uses quasiquoting that starts with ` and inserts , before inserting the necessary function call
(define (describe-path edge)
             `(there is a ,(caddr edge) going ,(cadr edge) from here))
                       