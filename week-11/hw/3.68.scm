(define (pairs s t)
  (interleave
   (stream-map
    (lambda (x)
            (list (stream-car s) x))
    t)
   (pairs (stream-cdr s)
          (stream-cdr t))))

;; it will fall into infinite loop
;; explanation: inside body of "pairs" procedure there is call of interleave
;; procedure, and we need to eval it's arguments first (since it is not a
;; special case, just an ordinary procedure). One of the args if the "pairs"
;; procedure itslef, thus it will fall into infinite recursion
