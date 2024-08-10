(define (last-pair l)
  (if (= (length l) 1)
    (car l)
    (last-pair (cdr l))))

(eq? (last-pair (list 1)) 1)
(eq? (last-pair (list 1 2 3 4)) 4)
