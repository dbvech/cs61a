(lambda (x) (+ x 3))
;; will output ref to a procedure

((lambda (x) (+ x 3)) 7)
;; will output 10 as a result of lambda execution with arg 7

(define (make-adder num)
  (lambda (x) (+ x num)))
;; will output a procedure name "make-adder"

((make-adder 3) 7)
;; will output 10

(define plus3 (make-adder 3))
;; will output var name "plus3"

(plus3 7)
;; will output 10

(define (square x) (* x x))
;; will output procedure name "square"

(square 5)
;; 25

(define sq (lambda (x) (* x x)))
;; will output name "sq"

(define (try f) (f 3 5))
;; will output name "try"

(try +)
;; 8

(try word)
;; 35
