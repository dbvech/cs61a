(load "stop-at")

(define (valentine customer-hand-so-far dealer-up-card)
  (define (has-heart? hand)
    (cond
      ((empty? hand) #f)
      ((eq? (last (first hand)) 'h) #t)
      (else (has-heart? (bf hand)))))
  ((stop-at (if (has-heart? customer-hand-so-far) 19 17))
   customer-hand-so-far
   dealer-up-card))
