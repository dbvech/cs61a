(define (substitute2 words old-words new-words)
  (define (substitute-word wd old-words new-words)
    (cond
      ((null? old-words) wd)
      ((eq? wd (car old-words)) (car new-words))
      (else (substitute-word wd (cdr old-words) (cdr new-words)))))

  (map
   (lambda (item)
           (if (list? item)
             (substitute2 item old-words new-words)
             (substitute-word item old-words new-words)))
   words))

(substitute2 '((4 calling birds) (3 french hens) (2 turtle doves)) '(1 2 3 4) '(one two three four))
