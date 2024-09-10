;; Explain in detail why the deadlock-avoidance method described above, 
;; (i.e., the accounts are numbered, and each process attempts to acquire 
;; the smaller-numbered account first) avoids deadlock in the exchange 
;; problem. Rewrite serialized-exchange to incorporate this idea. (You will also 
;; need to modify make-account so that each account is created with a number, 
;; which can be accessed by sending an appropriate message.)

(define (make-account-and-serializer acc-number balance) ; new param here
  (define (withdraw amount)
    (if (>= balance amount)
      (begin
       (set! balance (- balance amount))
       balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((balance-serializer
         (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            ((eq? m 'number) acc-number) ; new message
            ((eq? m 'balance) balance)
            ((eq? m 'serializer)
             balance-serializer)
            (else (error "Unknown request: 
                          MAKE-ACCOUNT"
                         m))))
    dispatch))

(define (serialized-exchange account1 account2)
  (if (> (account1 'number) (account2 'number))
    (let ((temp account1)) ; switch accounts here
      (set! account1 account2)
      (set! account2 temp)))
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer)))
    ((serializer1 (serializer2 exchange))
     account1
     account2)))
