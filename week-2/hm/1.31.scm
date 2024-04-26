(define (product term a next b)
  (if (> a b)
    1
    (* (term a) (product term (next a) next b))))

(define (identity x) x)
(define (inc x) (+ x 1))

(define (factorial x)
  (product identity 1 inc x))

; test factorial 
(factorial 0)
(factorial 1)
(factorial 2)
(factorial 5)
(factorial 10)

(define (pi-approx)
  (define (term x)
    (/ (* x (+ x 2)) (* (+ x 1) (+ x 1))))
  (define (next x) (+ x 2))
  (* 4.0 (product term 2 next 10000)))

(pi-approx)
