;; Write a procedure ends-e that takes a sentence as its argument and returns a sentence
;; containing only those words of the argument whose last letter is E:
;; > (ends-e ’(please put the salami above the blue elephant))
;; (please the above the blue)

(define (ends-e sent)
  (if (empty? sent)
    '()
    (sentence 
      (if (eq? (last (first sent)) 'e) (first sent) '()) 
      (ends-e (bf sent)))))

(ends-e '(please put the salami above the blue elephant))
