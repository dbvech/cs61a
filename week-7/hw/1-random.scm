(load "../../cs61a/lib/obj")

(define-class (random-generator max-num)
  (instance-vars (total 0))
  (method (count) total)
  (method (number)
          (set! total (+ 1 total))
          (random max-num)))

(define r10 (instantiate random-generator 10))
