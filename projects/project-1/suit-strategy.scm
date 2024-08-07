(load "stop-at")

(define (suit-strategy suit doesnt-include-strategy include-strategy)
  (define (has-suit? hand)
    (cond
      ((empty? hand) #f)
      ((eq? (last (first hand)) suit) #t)
      (else (has-suit? (bf hand)))))
  (lambda (customer-hand-so-far dealer-up-card)
          ((if (has-suit? customer-hand-so-far)
             include-strategy
             doesnt-include-strategy)
           customer-hand-so-far dealer-up-card)))

(define valentine-strategy (suit-strategy 'h (stop-at 17) (stop-at 19)))
