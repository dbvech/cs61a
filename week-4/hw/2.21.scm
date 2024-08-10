(define (square-list items)
  (if (null? items)
    (list)
    (cons (square (car items))
          (square-list (cdr items)))))

(square-list (list 1 2 3 4 5))

(define (square-list-2 items)
  (map square items))

(square-list-2 (list 1 2 3 4 5))
