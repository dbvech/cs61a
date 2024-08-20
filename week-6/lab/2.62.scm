(define (union-set set1 set2)
  (cond
    ((null? set1) set2)
    ((null? set2) set1)
    ((< (car set1) (car set2))
     (cons (car set1) (union-set (cdr set1) set2)))
    ((> (car set1) (car set2))
     (cons (car set2) (union-set set1 (cdr set2))))
    (else
     (cons (car set1) (union-set (cdr set1) (cdr set2))))))

(union-set (list 1 3 5 7 9) (list 4 5 6 7 9 10))
