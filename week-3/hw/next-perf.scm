(define (sum-of-factors n)
  (define (loop i acc)
    (cond
      ((= i 0) acc)
      ((= (remainder n i) 0) (loop (- i 1) (+ acc i)))
      (else (loop (- i 1) acc))))
  (loop
    (if (= (remainder n 2) 0) (/ n 2) (/ (- n 1) 2))
    0))

(define (next-perf n)
  (if (= (sum-of-factors n) n) n (next-perf (+ n 1))))

(next-perf 29)

; the answer is 496
