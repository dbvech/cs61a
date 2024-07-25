(define f 1)
f
; -> 1

(define (f) 2)
(f)
; -> 2

(define (f x) (+ x x))
(f 3)
; -> 6

(define (f) (lambda () 10))
((f))
; -> 10

(define (f)
  (lambda ()
          (lambda (x) (* x x))))
(((f)) 3)
; -> 9
