(define (iterative-improve good-enough? improve-guess)
  (define (try guess)
    (let ((next (improve-guess guess)))
      (if (good-enough? guess next)
        next
        (try next))))
  try)

; rewrite the sqrt procedure of 1.1.7 in terms of iterative-improve
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (define (average x y)
      (/ (+ x y) 2))
    (average guess (/ x guess)))

  ((iterative-improve good-enough? improve) 1.0))

; rewrite fixed-point procedure of 1.3.3 in terms of iterative-improve.
(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  ((iterative-improve
    (lambda (x) (close-enough? x (f x)))
    f)
   first-guess))
