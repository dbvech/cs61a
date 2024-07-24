(define (switch sent)
  (if (empty? sent)
    '()
    (sentence
     (switch (bl sent))
     (cond
       ((member? (last sent) '(I me)) 'you)
       ((member? (last sent) '(you)) (if (empty? (bl sent)) 'I 'me))
       (else (last sent))))))

(switch '(You told me that I should wake you up))

;;(i told you that you should wake me up)
