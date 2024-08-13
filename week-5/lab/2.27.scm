(define (deep-reverse lst)
  (cond
    ((null? lst) '())
    ((not (pair? lst)) lst)
    (else (append
           (deep-reverse (cdr lst))
           (list (deep-reverse (car lst)))))))

(define x
  (list (list 1 2) (list 3 4 (list 5 6 (list 7 8 9)))))

(deep-reverse x)
