(define (reverse lst)
  (if (null? lst)
    '()
    (append
     (reverse (cdr lst)) (list (car lst)))))

(reverse (list 1 2 3 4))
