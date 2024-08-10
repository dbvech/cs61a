(define (make-rational num den)
  (cons num den))
(define (numerator rat)
  (car rat))
(define (denominator rat)
  (cdr rat))
(define (*rat a b)
  (make-rational (* (numerator a) (numerator b))
                 (* (denominator a) (denominator b))))
(define (print-rat rat)
  (word (numerator rat) '/ (denominator rat)))

(print-rat (make-rational 2 3))
(print-rat (*rat (make-rational 2 3) (make-rational 1 4)))


(define (+rat a b)
  (make-rational (+ (* (numerator a) (denominator b))
                    (* (numerator b) (denominator a)))
                 (* (denominator a) (denominator b))))

(print-rat (+rat (make-rational 2 3) (make-rational 1 4)))
