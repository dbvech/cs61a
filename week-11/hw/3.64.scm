;; prerequisites
(define (average n1 n2) (/ (+ n1 n2) 2))

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

(define (sqrt-stream x)
  (define guesses
    (cons-stream
     1.0 (stream-map
          (lambda (guess)
                  (sqrt-improve guess x))
          guesses)))
  guesses)

;; solution
(define (stream-limit s tolerance)
  (let ((next (stream-car (stream-cdr s))))
    (if (<= (abs (- (stream-car s) next))
            tolerance)
      next
      (stream-limit (stream-cdr s) tolerance))))

;; tests
(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

(sqrt 9 0.00000001) ;; 3.0

