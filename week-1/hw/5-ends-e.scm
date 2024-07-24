(define (ends-e sent)
  (if (empty? sent)
    '()
    (sentence
      (if (eq? (last (first sent)) 'e)
        (first sent) 
        '())
      (ends-e (bf sent)))))

(ends-e '(please put the salami above the blue elephant))
