;; add support for compound sentences:
;; rename the procedure parse-sentence->parse-simple-sentence
(define (parse-simple-sentence)
  (list 'simple-sentence
        (parse-noun-phrase)
        (parse-verb-phrase)))

;; new procedure
(define (parse-sentence)
  (define (maybe-extend sentence)
    (amb sentence
         (maybe-extend (list 'sentence
                             sentence
                             (parse-word conjuctions)
                             (parse-simple-sentence)))))
  (maybe-extend (parse-simple-sentence)))

(define conjuctions '(conjuction but and or because so although while if since unless))

;;; Amb-Eval input:
(parse '(the professor lectures and the student sleeps))

;;; Starting a new problem
;;; Amb-Eval value:
(sentence
 (simple-sentence
  (simple-noun-phrase (article the) (noun professor))
  (verb lectures))
 (conjuction and)
 (simple-sentence
  (simple-noun-phrase (article the) (noun student))
  (verb sleeps)))

