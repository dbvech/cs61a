(define (substitute words old-word new-word)
  (map (lambda (w)
               (cond
                 ((list? w) (substitute w old-word new-word))
                 ((eq? w old-word) new-word)
                 (else w)))
       words))

(substitute '((lead guitar) (bass guitar) (rhythm guitar) drums) 'guitar 'axe)
