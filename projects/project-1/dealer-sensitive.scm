(load "best-total")

(define (dealer-sensitive customer-hand-so-far dealer-up-card)
  (cond
    ((and (member? (bl dealer-up-card) '(a 7 8 9 10 j q k))
          (< (best-total customer-hand-so-far) 17)) #t)
    ((and (member? (bl dealer-up-card) '(2 3 4 5 6))
          (< (best-total customer-hand-so-far) 12)) #t)
    (else #f)))
