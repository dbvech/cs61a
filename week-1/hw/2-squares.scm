(define (squares sent)
  (if (empty? sent)
    '()
    (sentence
     (square (first sent))
     (squares (bf sent)))))

(squares '(2 3 4 5))
