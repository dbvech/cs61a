;; Find the values of the expressions
;; ((t s) 0) ((t (t s)) 0) (((t t) s) 0)
;; where t is defined as in question 2 above, and s is defined as follows:
;; (define (s x)
;; (+ 1 x))

(define (t f)
  (lambda (x) (f (f (f x)))))

(define (s x)
  (+ 1 x))

((t s) 0)
;; -> should be 3

((t (t s)) 0)
;; -> should be 9

(((t t) s) 0)
;; -> should be 27
