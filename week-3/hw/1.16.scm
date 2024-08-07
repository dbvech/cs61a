(define (fast-expt b n)
  (define (fast-expt-iter b n a)
    (cond
      ((= n 0) a)
      ((even? n) (fast-expt-iter (square b) (/ n 2) a))
      (else (fast-expt-iter b (- n 1) (* a b)))))
  (fast-expt-iter b n 1))

(fast-expt 2 100)
