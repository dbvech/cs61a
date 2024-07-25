(define (substitute sent old-w new-w)
  (if (empty? sent)
    '()
    (sentence
     (if (equal? (first sent) old-w) new-w (first sent))
     (substitute (bf sent) old-w new-w))))

(substitute '(she loves you yeah yeah yeah) 'yeah 'maybe)
