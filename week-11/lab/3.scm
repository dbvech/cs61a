;; Consider the following two procedures.
(define (enumerate-interval low high)
  (if (> low high)
    '()
    (cons low (enumerate-interval (+ low 1) high))))

(define (stream-enumerate-interval low high)
  (if (> low high)
    the-empty-stream
    (cons-stream low (stream-enumerate-interval (+ low 1) high))))

;; What’s the difference between the following two expressions?
(delay (enumerate-interval 1 3))
;; this one returns a promise (procedure) which when will be executed
;; (passed to `force` proc) will return the list (1 2 3)

(stream-enumerate-interval 1 3)
;; this one wll return the pair (1 . promise)


