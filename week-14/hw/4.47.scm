;; load procedures from "parse-language.scm" file

(define (parse-verb-phrase)
  (amb (parse-word verbs)
       (list
        'verb-phrase
        (parse-verb-phrase)
        (parse-prepositional-phrase))))

;; let's examine the input sentence from the book 

;;; Amb-Eval input
(parse '(the professor lectures to the student with the cat))

;;; Amb-Eval value:
(sentence
 (simple-noun-phrase (article the) (noun professor))
 (verb-phrase
  (verb lectures)
  (prep-phrase (prep to)
               (noun-phrase
                (simple-noun-phrase (article the) (noun student))
                (prep-phrase (prep with)
                             (simple-noun-phrase (article the) (noun cat)))))))

;;; Amb-Eval input
try again

;;; Amb-Eval value:
(sentence
 (simple-noun-phrase (article the) (noun professor))
 (verb-phrase
  (verb-phrase (verb lectures)
               (prep-phrase (prep to)
                            (simple-noun-phrase (article the) (noun student))))
  (prep-phrase (prep with)
               (simple-noun-phrase (article the) (noun cat)))))

;;; Amb-Eval input
try again

;; Stuck, inifite loop here

;; This doesn't work, cause in 2nd branch of "amb" we have a recursive call,
;; so (after all valid options) it will continue to call itself (thus create 
;; new new branches) and fail.

;; If we interchange branches in the parse-verb-phrase it will fall into loop
;; from the first call.
