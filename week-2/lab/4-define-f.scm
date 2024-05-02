;; For each of the following expressions, what must f be in order for the evaluation of the expression to
;; succeed, without causing an error? For each expression, give a definition of f such that evaluating the
;; expression will not cause an error, and say what the expression’s value will be, given your definition.

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
