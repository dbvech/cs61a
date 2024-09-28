(define (analyze exp)
  (cond ((self-evaluating? exp)
         (analyze-self-evaluating exp))
        ; ...
        ((LET? EXP)
         (ANALYZE (LET->COMBINATION EXP)))
        ; ...
        (else
         (error "Unknown expression 
                 type: ANALYZE"
                exp))))
