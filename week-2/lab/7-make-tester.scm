(define (make-tester w)
  (lambda (x) (eq? x w)))

((make-tester 'hal) 'hal)

((make-tester 'hal) 'cs61a)

(define sicp-author-and-astronomer? (make-tester 'gerry))

(sicp-author-and-astronomer? 'hal)

(sicp-author-and-astronomer? 'gerry)
