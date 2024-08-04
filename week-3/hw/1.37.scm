; recursive process
(define (cont-frac-recur n d k)
  (define (iter i)
    (if (> i k)
      0
      (/ (n i) (+ (d i) (iter (+ i 1))))))
  (iter 1))

(cont-frac-recur (lambda (i) 1.0)
                 (lambda (i) 1.0)
                 10)

; iterative process
(define (cont-frac-iter n d k)
  (define (iter i result)
    (if (= i 0)
      result
      (iter (- i 1)
            (/ (n i) (+ (d i) result)))))
  (iter k 0))

(cont-frac-iter (lambda (i) 1.0)
                (lambda (i) 1.0)
                10)

;; the k should be min 10 to get an approximation that is accurate to 4 decimal places
