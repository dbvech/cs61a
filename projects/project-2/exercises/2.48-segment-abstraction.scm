(define (make-segment start-v end-v)
  (cons start-v end-v))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))
