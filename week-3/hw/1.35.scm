(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
        next
        (try next))))
  (try first-guess))

; golden ratio satisfies the equation g^2 = g + 1
; which can be transformed to
; -> g^2 / g = (g + 1) / g
; -> g = (g + 1) / g
; -> g = g/g + 1/g
; -> g = 1 + 1/g
; so we can calc fixed point of function f(g) |-> 1 + 1/g to determine golden ratio
(fixed-point (lambda (x) (+ 1 (/ 1.0 x))) 1)
