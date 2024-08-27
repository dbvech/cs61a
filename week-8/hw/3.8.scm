(define f (let ((c 2))
            (lambda (x)
                    (set! c (- c 1))
                    (* x c))))

(+ (f 0) (f 1))
;; here if we eval sub-exp from left to right, then
;; (+ (* 0 1) (* 1 0)) would be 0
;; but if we eval from right to left, then
;; (+ (* 0 0) (* 1 1)) would be 1
