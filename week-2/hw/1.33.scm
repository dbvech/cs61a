(define (filtered-accumulate filter combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner
     (if (filter a) (term a) null-value)
     (filtered-accumulate filter combiner null-value term (next a) next b))))


; helpers
(define (has-factors? x from to)
  (if (> from to)
    #f
    (if (= (remainder x from) 0)
      #t
      (has-factors? x (+ from 1) to))))

(define (prime? x)
  (cond
    ((< x 2) #f)
    ((= x 2) #t)
    (else (not (has-factors? x 2 (floor (sqrt x)))))))

(define (inc x) (+ x 1))

; 1.
; the sum of the squares of the prime numbers in the interval a
; to b (assuming that you have a prime? predicate already written)

(define (sum-squares-prime-numbers a b)
  (filtered-accumulate prime? + 0 square a inc b))

(sum-squares-prime-numbers 1 20)

; 2.
; the product of all the positive integers less than n
; that are relatively prime to n (i.e., all positive integers 
; i < n such that GCD(i,n)=1).

(define (product-positive-ints-prime-to n)
  (define (filter i) (and (< i n) (= (gcd i n) 1)))
  (filtered-accumulate filter * 1 (lambda (x) x) 1 inc n))

(product-positive-ints-prime-to 6) ; expect 5 (1*5)
(product-positive-ints-prime-to 10) ; expect 189 (1*3*7*9)
(product-positive-ints-prime-to 15) ; expect 896896 (1*2*4*7*8*11*13*14)
