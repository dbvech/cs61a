(define (spans-zero? x)
  (and (<= (lower-bound x) 0)
       (>= (upper-bound x) 0)))

(define (div-interval x y)
  (if (spans-zero? y)
    (error "The second interval spans zero, division not possible")
    (mul-interval x
                  (make-interval
                   (/ 1.0 (upper-bound y))
                   (/ 1.0 (lower-bound y))))))
