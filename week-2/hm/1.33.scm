;; You can obtain an even more general version of accumulate (Exercise 1.32)
;; by introducing the notion of a filter on the terms to be combined. That is,
;; combine only those terms derived from values in the range that satisfy a
;; specified condition. The resulting filtered-accumulate abstraction takes
;; the same arguments as accumulate, together with an additional predicate of
;; one argument that specifies the filter. Write filtered-accumulate as a procedure.
;; Show how to express the following using filtered-accumulate:

;; 1.
;; the sum of the squares of the prime numbers in the interval a to b
;; (assuming that you have a prime? predicate already written)
(define (filtered-accumulate filter? combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner
     (if (filter? a) (term a) null-value)
     (filtered-accumulate filter? combiner null-value term (next a) next b))))

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

(define (sum-squares-prime a b)
  (define (term x) (* x x))
  (filtered-accumulate prime? + 0 term a inc b))

(sum-squares-prime 1 20) ; test, should be 1027

;; 2.
;; the product of all the positive integers less than n
;; that are relatively prime to n
;; (i.e., all positive integers i<n such that GCD(i,n)=1).
(define (gcd a b)
  (define lo (if (< a b) a b))
  (define hi (if (> a b) a b))

  (cond
    ((= lo 0) hi)
    ((= hi 0) lo)
    (else (gcd lo (remainder hi lo)))))

(define (product-positive-less n)
  (define (term x) x)
  (define (predicate? x)
    (= (gcd x n) 1))
  (filtered-accumulate predicate? * 1 term 1 inc (- n 1)))

(product-positive-less 6) ; expect 5 (1*5)
(product-positive-less 10) ; expect 189 (1*3*7*9)
(product-positive-less 15) ; expect 896896 (1*2*4*7*8*11*13*14)
