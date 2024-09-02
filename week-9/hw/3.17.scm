(define (count-pairs x)
  (let ((result 0) (processed-list '()))
    (define (loop struct)
      (cond
        ((not (pair? struct)) 'done)
        ((memq struct processed-list) 'done)
        (else
         (set! result (+ 1 result))
         (set! processed-list (cons struct processed-list))
         (loop (car struct))
         (loop (cdr struct)))))
    (loop x)
    result))
