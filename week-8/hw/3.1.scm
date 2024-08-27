(define (make-accumulator sum)
  (lambda (val)
          (set! sum (+ sum val))
          sum))
