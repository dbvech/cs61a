(define (square x cont)
  (cont (* x x)))

(square 5 (lambda (x) x))
;; => 25

(square 5 (lambda (x) (+ x 2)))
;; => 27

(square 5 (lambda (x) (square x (lambda (x) x))))
;; => 625

(square 5 display)
;; => 5

(define foo 3)
;; => foo

(square 5 (lambda (x) (set! foo x)))

foo
;; => 25

(define (reciprocal x yes no)
  (if (= x 0)
    (no x)
    (yes (/ 1 x))))
;; => reciprocal

(reciprocal
 3
 (lambda (x) x)
 (lambda (x) (se x '(cannot reciprocate))))
;; => 0.33333333333333

(reciprocal
 0
 (lambda (x) x)
 (lambda (x) (se x '(cannot reciprocate))))
;; => (0 cannot reciprocate)
