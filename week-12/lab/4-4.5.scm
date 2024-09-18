;; this procedure was modified
(define (expand-clauses clauses)
  (if (null? clauses)
    'false
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (if (cond-else-clause? first)
        (if (null? rest)
          (sequence->exp (cond-actions first))
          (error "ELSE clause isn't last -- COND->IF"
                 clauses))
        ;; vvv THIS CODE WAS ADDED
        (if (cond-arrow-clause? first)
          (list (make-lambda
                 (list '*value*)
                 (make-if '*value*
                          (list (cond-arrow-clause first) '*value*)
                          (expand-clauses rest)))
                (cond-predicate first))
          ;; ^^^ THIS CODE WAS ADDED
          (make-if (cond-predicate first)
                   (sequence->exp (cond-actions first))
                   (expand-clauses rest)))))))

;; new procedures
(define (cond-arrow-proc exp) (caddr exp))

(define (cond-arrow-clause? clause)
  (eq? (cond-actions clause) '=>))
