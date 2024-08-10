(define (make-point x y)
  (cons x y))
(define (x-point p)
  (car p))
(define (y-point p)
  (cdr p))

;; solution
(define (make-rectangle top-left width height)
  (cons top-left (cons width height)))

(define (top-left r)
  (car r))

(define (rec-width r)
  (car (cdr r)))

(define (rec-height r)
  (cdr (cdr r)))

;; next layer
;; same rec-perimeter and rec-area as in 2.3.scm
(define (rec-perimeter r)
  (+ (* (rec-width r) 2)
     (* (rec-height r) 2)))

(define (rec-area r)
  (* (rec-width r) (rec-height r)))

;; test
(define test-rectangle (make-rectangle
                        (make-point 2 2) 5 3))

(rec-width test-rectangle) ; -> 5
(rec-height test-rectangle) ; -> 3
(rec-perimeter test-rectangle) ; -> 16
(rec-area test-rectangle) ; -> 15
