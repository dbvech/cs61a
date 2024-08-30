(define x (cons 1 3))
(define y 2)

;; A CS 61A student, intending to change the value of x to a pair with car equal to 1 
;; and cdr equal to 2, types the expression (set! (cdr x) y) instead of (set-cdr! x y) 
;; and gets an error. Explain why.

;; ANSWER
;; Because set! is a special form and has signature (set! VARIABLE_NAME VALUE), 
;; scheme evaluates a VALUE and then assigns it as a value of VARIABLE_NAME if it's found (in the env), 
;; otherwise throws an error. (cdr x) is NOT a variable name, thats why it throws an error.
