(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance
                   (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch secret m)
    (cond
      ((not (eq? secret password)) (lambda (_) "Incorrect password"))
      ((eq? m 'withdraw) withdraw)
      ((eq? m 'deposit) deposit)
      (else (error "Unknown request: 
                 MAKE-ACCOUNT" m))))
  dispatch)

(define (make-joint acc password joint-acc-password)
  (lambda (secret m)
          (if (eq? secret joint-acc-password)
            (acc password m)
            (lambda (_) "Incorrect password"))))
