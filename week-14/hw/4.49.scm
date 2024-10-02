(define (parse-word word-list)
  (define (loop words)
    (require (not (null? words)))
    (amb (car words) (loop (cdr words))))
  (list (car word-list) (loop (cdr word-list))))

(define nouns
  '(noun student professor cat class))

(define verbs
  '(verb studies lectures eats sleeps))

(define articles '(article the a))

(define (parse-sentence)
  (list 'sentence
        (parse-noun-phrase)
        (parse-verb-phrase)))

(define (parse-noun-phrase)
  (list 'simple-noun-phrase
        (parse-word articles)
        (parse-word nouns)))

(define (parse-verb-phrase)
  (parse-word verbs))

(sentence (simple-noun-phrase (article the) (noun student)) (verb studies))
(sentence (simple-noun-phrase (article the) (noun student)) (verb lectures))
(sentence (simple-noun-phrase (article the) (noun student)) (verb eats))
(sentence (simple-noun-phrase (article the) (noun student)) (verb sleeps))
(sentence (simple-noun-phrase (article the) (noun professor)) (verb studies))
(sentence (simple-noun-phrase (article the) (noun professor)) (verb lectures))
(sentence (simple-noun-phrase (article the) (noun professor)) (verb eats))
(sentence (simple-noun-phrase (article the) (noun professor)) (verb sleeps))
(sentence (simple-noun-phrase (article the) (noun cat)) (verb studies))
(sentence (simple-noun-phrase (article the) (noun cat)) (verb lectures))
(sentence (simple-noun-phrase (article the) (noun cat)) (verb eats))
(sentence (simple-noun-phrase (article the) (noun cat)) (verb sleeps))
(sentence (simple-noun-phrase (article the) (noun class)) (verb studies))
(sentence (simple-noun-phrase (article the) (noun class)) (verb lectures))
(sentence (simple-noun-phrase (article the) (noun class)) (verb eats))
(sentence (simple-noun-phrase (article the) (noun class)) (verb sleeps))
(sentence (simple-noun-phrase (article a) (noun student)) (verb studies))
(sentence (simple-noun-phrase (article a) (noun student)) (verb lectures))
(sentence (simple-noun-phrase (article a) (noun student)) (verb eats))
;; and so on...
