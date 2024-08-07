(define (reckless strategy)
  (lambda (customer-hand-so-far dealer-up-card)
          (strategy (bl customer-hand-so-far) dealer-up-card)))
