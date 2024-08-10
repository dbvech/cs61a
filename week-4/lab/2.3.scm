(define (make-point x y)
  (cons x y))
(define (x-point p)
  (car p))
(define (y-point p)
  (cdr p))

;; solution
(define (make-rectangle top-left bottom-right)
  (cons top-left bottom-right))

(define (top-left r)
  (car r))
(define (bottom-right r)
  (cdr r))

(define (rec-width r)
  (abs (-
        (x-point (top-left r))
        (x-point (bottom-right r)))))

(define (rec-height r)
  (abs (-
        (y-point (top-left r))
        (y-point (bottom-right r)))))

;; next layer
(define (rec-perimeter r)
  (+ (* (rec-width r) 2)
     (* (rec-height r) 2)))

(define (rec-area r)
  (* (rec-width r) (rec-height r)))

;; test
(define test-rectangle (make-rectangle
                        (make-point 2 2) (make-point 7 5)))

(rec-width test-rectangle) ; -> 5
(rec-height test-rectangle) ; -> 3
(rec-perimeter test-rectangle) ; -> 16
(rec-area test-rectangle) ; -> 15
