(define (match? pattern lst)
  (define (match-helper pat lst)
    (cond
      ((null? pat) (null? lst))
      ((eq? (car pat) '*)
       (or (match-helper (cdr pat) lst)
           (and (not (null? lst)) (match-helper pat (cdr lst)))))
      ((null? lst) #f)
      ((equal? (car pat) (car lst)) (match-helper (cdr pat) (cdr lst)))
      (else #f)))
  (match-helper pattern lst))

(define (search pattern data)
  (mapreduce
   (lambda (input-kv-pair)
           (if (match? pattern (kv-value input-kv-pair))
             (list input-kv-pair)
             '()))
   cons
   '()
   data))
