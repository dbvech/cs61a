;; Write a procedure squares that takes a sentence of numbers as its argument and
;; returns a sentence of the squares of the numbers:
;; > (squares ’(2 3 4 5))
;; (4 9 16 25)

(define (squares nums)
  (if (empty? nums)
    '()
    (sentence (square (first nums)) (squares (bf nums)))))

(squares '(2 3 4 5))
