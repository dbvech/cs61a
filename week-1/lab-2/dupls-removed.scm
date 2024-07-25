(define (dupls-removed sent)
  (if (empty? sent)
    '()
    (sentence
     (if (member? (first sent) (bf sent)) '() (first sent))
     (dupls-removed (bf sent)))))

(dupls-removed '(a b c a e d e b))
(dupls-removed '(a b c))
(dupls-removed '(a a a a b a a))
