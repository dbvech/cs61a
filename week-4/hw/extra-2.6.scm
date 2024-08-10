(define (add-1 n)
  (lambda (f) (lambda (x)
                      (f ((n f) x)))))

(define zero
  (lambda (f) (lambda (x)
                      x)))

(define one
  (lambda (f) (lambda (x)
                      (f x))))

(define two
  (lambda (f) (lambda (x)
                      (f (f x)))))

(define (add n m)
  (lambda (f) (lambda (x)
                      ((n f) ((m f) x)))))

(define (multi n m)
  (lambda (f) (lambda (x)
                      ((n (m f)) x))))

(define (exponential n m)
  (lambda (f) (lambda (x)
                      (((m n) f) x))))

(define (plus-1 x) (+ x 1))

;; tests
(define three (add-1 two))

(((add three two) plus-1) 0)

(((multi three two) plus-1) 0)

(((exponential three two) plus-1) 0)
