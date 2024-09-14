;; Prerequisites
(define (integers-starting-from n)
  (cons-stream
   n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))

(define (add-streams s1 s2)
  (cons-stream (+ (stream-car s1) (stream-car s2))
               (add-streams (stream-cdr s1) (stream-cdr s2))))

;; Solution
(define (partial-sum s)
  (define result
    (cons-stream (stream-car s)
                 (add-streams (stream-cdr s) result)))
  result)

;; Tests
(define test (partial-sum integers)) ; 1, 3, 6, 10, 15, 21...
(stream-ref test 4) ;; 15
