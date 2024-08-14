(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest))
            (cdr rest))))
  (trace iter)
  (iter initial sequence))

(define (fold-right op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (fold-right op initial (cdr sequence)))))

;; What are the values of 

(fold-right / 1 (list 1 2 3)) ; 1 / (2 / (3 / 1)) - > 3/2
(fold-left / 1 (list 1 2 3)) ; (((1 / 1) / 2) / 3) -> 1/6
(fold-right list '() (list 1 2 3)) ; (1 (2 (3 ())))
(fold-left list '() (list 1 2 3)) ; (((() 1) 2) 3)

;; Give a property that op should satisfy to guarantee that fold-right and fold-left will produce the same values for any sequence.

;; OP must satisfy next property: if we change the order of args it still should give same output
;; (op a b) should be same as (op b a)
(fold-right + 0 (list 1 2 3)) ; 6
(fold-left + 0 (list 1 2 3)) ; 6
