;; inside eval
((quoted? exp) (eval-quoted exp env))

;; new proc
(define (eval-quoted exp env)
  (define (loop exp)
    (if (pair? exp)
      (mc-apply (lookup-variable-value 'cons env)
                (list (loop (car exp))
                      (loop (cdr exp)))
                env)
      exp))
  (loop (text-of-quotation exp)))

