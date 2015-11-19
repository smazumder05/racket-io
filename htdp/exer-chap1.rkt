;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-chap1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;  Rule of thumb from Chapter1
;  1. Simplify the outermost and the left most sub-expression that is ready for evaluation
;  2. Raise input errors by calling the error function

(define str "helloworld")
(string-append (substring str 0 5) (string-append "-" (substring str 5)))
(define x 2)
(define inverse-of-x (if (= x 0) 0 (/ 1 x)))
(* (+ (string-length "42") 1)pi)

; An expression that converts whatever in reprsents to a number. For a string it
; determines how long the string is; for a number it decrements the number unless it
; is already 0 or negative; for true is uses 10 and for false it uses 20

(define in  true)
(if (number? in) (if (<= in 0) in (- in 1)) (if (string? in) (string-length in) (if (boolean? in) (if (false? in) 20 10) "Not-Known")))

(cond
  [(zero? 3) 1]
  [(= 3 3) (+ 1 1)]
  [else 3])

;Ex 122 
(+ (* (/ 12 8) 2/3)
   (- 20 (sqrt 4)))


(cond
  [(= 0 0) #false]
  [(> 0 1) (string=? "a" "a")]
  [else (= (/ 1 2) 9)])

(cond
  [(= 2 0) #false]
  [(> 2 1) (string=? "a" "a")]
  [else (= (/ 1 2) 9)])

; demonstrate stuck state
;(+ (* 20 2) (/ 1 (- 10 10)))


;demonstrates usage of input error check and calling error function
(define (area-of-disk x) (* x x))

(define (checked-area-of-disk v)
  (cond
    [(number? v) (area-of-disk v)]
    [else (error "number expected.")]))

;definition of boolean AND/OR function using cond
(define (xand x y)
  (cond
    [x (if y #true #false)]
    [else #false]))

(define (x-or x y)
  (cond
    [ x #true]
    [else (if y #true #false)]))

;Ex 124 - define if in terms of a cond

(define (xif exp-test exp-then exp-else)
  (cond
    [exp-test exp-then]
    [else exp-else]))

;Ex 126
(define-struct oops[]) ; is legal def
(define-struct child[parent dob date]) ;is legal def
;(define-struct (child person) [dob date]) ; is illegal

;Ex 128
(define-struct ball[x y speed-x speed-y])
;1
(number? (make-ball 1 2 3 4)) ; evaluates to false since it is a struct
;2
(ball-speed-y (make-ball (+ 1 2) (+ 3 3) 2 3)) ; Ans 3
;3
(ball-y (make-ball (+ 1 2) (+ 3 3) 2 3)) ; Ans 6
;4
(ball-x (make-posn 1 2)) ;


