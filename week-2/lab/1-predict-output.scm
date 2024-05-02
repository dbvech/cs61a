(lambda (x) (+ x 3))
; -> procedure "link"

((lambda (x) (+ x 3)) 7)
; -> 10

(define (make-adder num)
  (lambda (x) (+ x num)))
; -> procedure "link"

((make-adder 3) 7)
; -> 10

(define plus3 (make-adder 3))
; -> procedure "link"

(plus3 7)
; -> 10

(define (square x) (* x x))
; -> procedure "link"

(square 5)
; -> 25

(define sq (lambda (x) (* x x)))
; -> procedure "link"

(sq 5)
; -> 25

(define (try f) (f 3 5))
; -> procedure "link"

(try +)
; 8

(try word)
; 35
