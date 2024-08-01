; f - numerical fn
; n - pos integer

(define (repeated f n)
  (lambda (x)
          (if (< n 2)
            (f x)
            (f ((repeated f (- n 1)) x)))))

((repeated square 2) 5)
