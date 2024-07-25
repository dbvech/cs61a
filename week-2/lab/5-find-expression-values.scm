;; Find the values of the expressions
;; ((t 1+) 0) ((t (t 1+)) 0) (((t t) 1+) 0)
;; where 1+ is a primitive procedure that adds 1 to its argument, and t is defined as follows:

(define (1+ x) (+ 1 x))

(define (t f)
  (lambda (x) (f (f (f x)))))

;; Work this out yourself before you try it on the computer!

((t 1+) 0)
;; -> should be 3

((t (t 1+)) 0)
;; -> should be 9

(((t t) 1+) 0)
;; -> should be 27
