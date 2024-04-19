(define (square x) (* x x))
(define (sum-squares a b) (+ (square a) (square b)))

(define (sum-squares-of-two-largest a b c)
  (cond
    ((and (<= a b) (<= a c)) (sum-squares b c))
    ((and (<= b a) (<= b c)) (sum-squares a c))
    (else (sum-squares a b))))


(sum-squares-of-two-largest 1 2 3)
(sum-squares-of-two-largest 5 2 4)
(sum-squares-of-two-largest 7 7 7)
(sum-squares-of-two-largest -3 0 1)
(sum-squares-of-two-largest 10 10 5)
