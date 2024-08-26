(define (make-adder n)
  (lambda (x) (+ x n)))
;; -> make-adder

(make-adder 3)
;; -> procedure

((make-adder 3) 5)
;; will evaluate procedure returned by (make-adder 3) with arg 5
;; -> 8

(define (f x) (make-adder 3))
;; -> f

(f 5)
;; -> procedure (returned by (make-adder 3))

(define g (make-adder 3))
;; -> g

(g 5)
;; -> 8

(define (make-funny-adder n)
  (lambda (x)
          (if (equal? x 'new)
            (set! n (+ n 1))
            (+ x n))))
;; -> make-funny-adder

(define h (make-funny-adder 3))
;; -> h

(define j (make-funny-adder 7))
;; -> j

(h 5)
;; -> 8

(h 5)
;; -> 8

(h 'new)
;; -> 3

(h 5)
;; -> 9

(j 5)
;; -> 12

(let ((a 3))
  (+ 5 a))
;; -> 8

((let ((a 3))
   (lambda (x) (+ x a)))
 5)
;; let will return new lambda (form let body), which we invoke with arg 5
;; -> 8

((lambda (x)
         (let ((a 3))
           (+ x a)))
 5)
;; -> 8

(define k
  (let ((a 3))
    (lambda (x) (+ x a))))
;; -> k

(k 5)
;; -> 8

(define m
  (lambda (x)
          (let ((a 3))
            (+ x a))))
;; -> m

(m 5)
;; -> 8

(define p
  (let ((a 3))
    (lambda (x)
            (if (equal? x 'new)
              (set! a (+ a 1))
              (+ x a)))))
;; -> p

(p 5)
;; -> 8

(p 5)
;; -> 8

(p 'new)
;; -> 3

(p 5)
;; -> 9

(define r
  (lambda (x)
          (let ((a 3))
            (if (equal? x 'new)
              (set! a (+ a 1))
              (+ x a)))))
;; -> r

(r 5)
;; -> 8

(r 5)
;; -> 8

(r 'new)
;; -> 3

(r 5)
;; -> 9

(define s
  (let ((a 3))
    (lambda (msg)
            (cond
              ((equal? msg 'new)
               (lambda ()
                       (set! a (+ a 1))))
              ((equal? msg 'add)
               (lambda (x) (+ x a)))
              (else (error "huh?"))))))
;; -> s

(s 'add)
;; -> procedure

(s 'add 5)
;; procedure S accepts only ONE arg
;; -> ERROR

((s 'add) 5)
;; -> 8

(s 'new)
;; procedure

((s 'add) 5)
;; -> 8

((s 'new))
;; -> 3

((s 'add) 5)
;; -> 9

(define (ask obj msg . args)
  (apply (obj msg) args))
;; -> ask

(ask s 'add 5)
;; -> 9

(ask s 'new)
;; -> 4

(ask s 'add 5)
;; -> 10

(define x 5)
;; -> x

(let ((x 10)
      (f (lambda (y) (+ x y))))
  (f 7))
;; it will take X defined in global env, which is 5
;; -> 12

(define x 5)
;; -> x
