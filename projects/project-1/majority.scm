(define (majority strategy-1 strategy-2 strategy-3)
  (lambda (customer-hand-so-far dealer-up-card)
          (< 1
             (+
              (if (strategy-1 customer-hand-so-far dealer-up-card) 1 0)
              (if (strategy-2 customer-hand-so-far dealer-up-card) 1 0)
              (if (strategy-3 customer-hand-so-far dealer-up-card) 1 0)))))
