(define (fract-stream l)
  (cons-stream (quotient (* (car l) 10) (cadr l))
               (fract-stream (list (remainder (* (car l) 10)
                                              (cadr l))
                                   (cadr l)))))
(fract-stream '(1 7))
;; => (1 . *promise*)

(stream-car (fract-stream '(1 7)))
;; => 1

(stream-car (stream-cdr (stream-cdr (fract-stream '(1 7)))))
;; => 2

(define (approximation s numdigits)
  (if (= numdigits 0)
    '()
    (cons (stream-car s) (approximation (stream-cdr s) (- numdigits 1)))))

(approximation (fract-stream '(1 7)) 4)
;; => (1 4 2 8)

(approximation (fract-stream '(1 2)) 4)
;; => (5 0 0 0)
