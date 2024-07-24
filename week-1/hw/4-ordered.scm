(define (ordered? sent)
  (if (< (count sent) 2)
    #t
    (and (< (first sent) (first (bf sent)))
         (ordered? (bf sent)))))


(ordered? '(1))

(ordered? '(1 10))

(ordered? '(1 2 5 7 10))

(ordered? '(1 2 10 7 1))
