;; integer->rational->real->complex

;; in integer package
(define (integer->rational int)
  (make-rational int 1))
(put 'raise '(integer) integer->rational)

;; in rational package
(define (rational->real rat)
  (make-real (/ (numer x) (denom x))))
(put 'raise '(rational) rational->real)

;; in real package
(define (real->complex rl)
  (make-complex-from-real-imag rl 0))
(put 'raise '(real) real->complex)

;; generic operation in program
(define (raise n)
  (apply-generic 'raise n))
