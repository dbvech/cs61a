(define (center i)
  (/ (+ (lower-bound i)
        (upper-bound i))
     2))

(define (make-center-percent center pct-tolerance)
  (let ((tolerance (* center (/ pct-tolerance 100))))
    (make-interval (- center tolerance)
                   (+ center tolerance))))

(define (percent i)
  (* (/ (- (center i) (lower-bound i))
        (center i))
     100))
