;; version 1
(define (equal? l1 l2)
  (if (not (pair? l1))
    (eq? l1 l2)
    (and (equal? (car l1) (car l2))
         (equal? (cdr l1) (cdr l2)))))

;; version 2
(define (equal? l1 l2)
  (if (not (pair? l1))
    (eq? l1 l2)
    (accumulate and (map equal? l1 l2))))

(equal? '(this is a list)
        '(this is a list))

(equal? '(this is a list)
        '(this (is a) list))

(equal? '(this (is a) list)
        '(this (is a) list))

(equal? '(this (is a) list)
        '(this (is a b) list))

(equal? '() '())
