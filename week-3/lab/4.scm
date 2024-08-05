(define (type-check f check? arg)
  (if (check? arg)
    (f arg)
    #f))

(type-check sqrt number? 'hello)
(type-check sqrt number? 4)
