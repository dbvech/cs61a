;; Write a procedure switch that takes a sentence as its argument and returns a sentence
;; in which every instance of the words I or me is replaced by you, while every instance of
;; you is replaced by me except at the beginning of the sentence, where it’s replaced by I.
;; (Don’t worry about capitalization of letters.) Example:
;; > (switch ’(You told me that I should wake you up))
;; (i told you that you should wake me up)

(define (switch sent)
  (if (empty? sent)
    '()
    (sentence
     (switch (bl sent))
     (cond
       ((member? (last sent) '(I i Me me)) 'you)
       ((member? (last sent) '(You you)) (if (= (count sent) 1) 'I 'me))
       (else (last sent))))))

(switch '(You told me that I should wake you up))
