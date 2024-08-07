(load "twenty-one")

(define (play-n strategy n)
  (define (iter score i)
    (if (= i 0)
      score
      (iter (+ score (twenty-one strategy)) (- i 1))))
  (iter 0 n))
