;; "apply" procedure need to determine whether a "procedure" argument is a 
;; primitive OR compound proc. If will not work if there will be a thunk

(define plus ((lambda (fn) fn) +))

;; here + will not be evaluated and becomes a thunk
;; then variable "plus" will be defined (in env) with value of that thunk

(plus 1 2)

;; then (in eval)
;; (apply (eval (operator '(plus 1 2)) env)
;;           (operands '(plus 1 2))
;;           env))

;; (eval operator 'plus) will return a thunk
;; so, procedure "apply" will fail on determining what to do in cond.

