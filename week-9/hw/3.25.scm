(define (assoc key records)
  (cond ((null? records) #f)
    ((equal? key (caar records))
     (car records))
    (else (assoc key (cdr records)))))

(define (is-table? maybe-table)
  (and (pair? maybe-table) (pair? (car maybe-table))))

(define (make-table)
  (list '*table*))

(define (insert! keys-list value table)
  (if (null? keys-list)
    (set-cdr! table value)
    (let ((key (car keys-list)))
      (let ((record (and (is-table? (cdr table))
                         (assoc key (cdr table)))))
        (if record
          (insert! (cdr keys-list) value record)
          (let ((new-record (cons key nil)))
            (set-cdr! table
                      (cons new-record (if (is-table? (cdr table)) (cdr table) '())))
            (insert! (cdr keys-list) value (cadr table))))))))

(define (lookup keys-list table)
  (if (null? keys-list)
    (cdr table)
    (let ((key (car keys-list)))
      (let ((record (and (is-table? (cdr table))
                         (assoc key (cdr table)))))
        (if record
          (lookup (cdr keys-list) record)
          #f)))))

(define table (make-table))

(insert! '(test2 deep2 deep3 deep4) 3 table)
(lookup '(test2 deep2 deep3 deep4) table)
