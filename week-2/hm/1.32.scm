(define (accumulate combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner (term a) (accumulate combiner null-value term (next a) next b))))

(define (identity x) x)
(define (inc x) (+ x 1))

(define (sum a b)
  (accumulate + 0 identity a inc b))

(define (produce a b)
  (accumulate * 1 identity a inc b))

(sum 1 10)
(produce 1 5)
