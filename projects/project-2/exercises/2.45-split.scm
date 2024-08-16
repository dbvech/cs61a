(define (split origin-pos split-pos)
  (lambda (painter n)
          (if (= n 0)
            painter
            (let ((smaller
                   ((split origin-pos split-pos) painter (- n 1))))
              (origin-pos painter
                          (split-pos smaller smaller))))))

(define right-split (split beside below))
(define up-split (split below beside))
