;; Consider a Scheme function "g" for which the expression
;; ((g) 1)
;; returns the value 3 when evaluated. Determine how many arguments "g" has.
;; In one word, also describe as best you can the type of value returned by g.

;; Function "g" doesn't have any arguments as we invoke it like "(g)"
;; The return type of it is an another procedure which takes one argument and maybe sum it with number 2
;; the example of function "g" that returns lambda 

(define (g) (lambda (x) (+ x 2)))

((g) 1)
;; -> 3
