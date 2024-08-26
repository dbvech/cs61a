(define (plus1 var)
  (set! var (+ var 1))
  var)

(plus1 5)
;; 1. using substituion model first we need to eval all sub expressions in the list ()
;;    plus1 - will be evaluated to procedure
;;    5 - it's just 5
;; 2. next we need to apply procedure plus1 to arg 5
;;    for this in substituion model we need to replace all occurencies of formal parameter
;;    "var" (in the procedure BODY) with actual arg "5", so we will have
;;    (set! 5 (+ 5 1)
;;    5)
;;    the expression (set! 5 ...) is wrong, cause there is no variable with name "5", so it
;;    should result to error
;;    even, if it will not result to error, then return will be 5, which is wrong, cause
;;    we suppose to change var to be 6 and return 6.
