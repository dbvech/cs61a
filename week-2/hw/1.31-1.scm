(define (product term a next b)
  (if (> a b)
    1
    (* (term a) (product term (next a) next b))))

(define (identity x) x)
(define (inc x) (+ x 1))

(define (factorial n)
  (product identity 1 inc n))

(factorial 2)
(factorial 6)
(factorial 10)

(define pi (* (product
               (lambda (x) (/ (* x (+ x 2)) (* (+ x 1) (+ x 1))))
               2
               (lambda (x) (+ x 2))
               10000) 4.0))

; test
pi
