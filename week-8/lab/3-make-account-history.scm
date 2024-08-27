(define (make-account init-amount)
  (let ((balance init-amount) (transactions '()))
    (define (withdraw amount)
      (set! balance (- balance amount))
      (set! transactions (append transactions (list (list 'withdraw amount))))
      balance)
    (define (deposit amount)
      (set! balance (+ balance amount))
      (set! transactions (append transactions (list (list 'deposit amount))))
      balance)
    (define (dispatch msg)
      (cond
        ((eq? msg 'withdraw) withdraw)
        ((eq? msg 'deposit) deposit)
        ((eq? msg 'balance) balance)
        ((eq? msg 'transactions) transactions)))
    dispatch))