;; Write a predicate ordered? that takes a sentence of numbers as its argument and
;; returns a true value if the numbers are in ascending order, or a false value otherwise

(define (ordered? sent)
  (if (= (count sent) 1)
    #t
    (if (> (first sent) (first (bf sent)))
      #f
      (ordered? (bf sent)))))

(ordered? '(1 2 3))
(ordered? '(2 3))
(ordered? '(2 1 3))
(ordered? '(10 1 3))
(ordered? '(10 11 30))
