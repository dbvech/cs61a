(define (same-parity x . l)
  (define (iter test? l)
    (cond
      ((null? l) '())
      ((test? (car l)) (cons (car l) (iter test? (cdr l))))
      (else (iter test? (cdr l)))))
  (iter (if (even? x) even? odd?) l))

(same-parity 1 2 3 4 5 6 7 8 9 10)
