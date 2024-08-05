(define (make-safe f check?)
  (lambda (arg)
          (if (check? arg) (f arg) #f)))

(define safe-sqrt (make-safe sqrt number?))

(safe-sqrt 'wrong)
(safe-sqrt 4)
