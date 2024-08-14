(define (accumulate op initial seq)
  (if (null? seq)
    initial
    (op (car seq) (accumulate op initial (cdr seq)))))

;; Scheme calculator -- evaluate simple expressions

; The read-eval-print loop:

(define (calc)
  (newline)
  (display "calc: ")
  (display (calc-eval (read)))
  (newline)
  (calc))

; Evaluate an expression:

(define (calc-eval exp)
  (cond ((number? exp) exp)
    ((word? exp) exp)
    ((list? exp) (calc-apply (car exp) (map calc-eval (cdr exp))))
    (else (error "Calc: bad expression:" exp))))

; Apply a function to arguments:

(define (calc-apply fn args)
  (cond ((eq? fn '+) (accumulate + 0 args))
    ((eq? fn '-) (cond ((null? args) (error "Calc: no args to -"))
                   ((= (length args) 1) (- (car args)))
                   (else (- (car args) (accumulate + 0 (cdr args))))))
    ((eq? fn '*) (accumulate * 1 args))
    ((eq? fn '/) (cond ((null? args) (error "Calc: no args to /"))
                   ((= (length args) 1) (/ (car args)))
                   (else (/ (car args) (accumulate * 1 (cdr args))))))
    ((eq? fn 'first) (apply first args))
    ((eq? fn 'butfirst) (apply butfirst args))
    ((eq? fn 'last) (apply last args))
    ((eq? fn 'butlast) (apply butlast args))
    ((eq? fn 'word) (apply word args))
    (else (error "Calc: bad operator:" fn))))
