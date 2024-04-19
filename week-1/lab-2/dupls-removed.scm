(define (dupls-removed sent)
  (cond
    ((= (count sent) 1) (first sent))
    ((member? (first sent) (butfirst sent)) (dupls-removed (butfirst sent)))
    (else (sentence (first sent) (dupls-removed (butfirst sent))))))


(dupls-removed '(a b c a e d e b))
(dupls-removed '(a b c))
(dupls-removed '(a a a a b a a))
