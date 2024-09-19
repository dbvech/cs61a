;; change make-frame procedure to handle type checks, add new formal parameter
;; base-env cause we need to eval predicated procedure
(define (make-frame variables values base-env)
  (define (type-check var val)
    (if (and (pair? var)
             (not (mc-apply (mc-eval (car var) base-env) (list val))))
      (error "Error: wrong argument -- " val)))

  (for-each type-check variables values)
  (cons (map (lambda (p) (if (pair? p) (cadr p) p)) variables) values))

;; edit extend-environment procedure to pass base-env arg into make-frame invocation
(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
    (cons (make-frame vars vals base-env) BASE-ENV)
    (if (< (length vars) (length vals))
      (error "Too many arguments supplied" vars vals)
      (error "Too few arguments supplied" vars vals))))

;; add missing primitive procedures
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list '+ +)
        (list '- -)
        (list '* *)
        (list '/ /)
        (list '= =)
        (list 'list list)
        (list 'append append)
        (list 'equal? equal?)
        (LIST 'INTEGER? INTEGER?)
        (LIST 'NOT NOT)
        (LIST 'LIST-REF LIST-REF)
;;      more primitives
        ))
