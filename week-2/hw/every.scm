; Last week you wrote procedures squares, that squared each number 
; in its argument sentence, and saw pigl-sent, that pigled each word 
; in its argument sentence. Generalize this pattern to create a 
; higher-order procedure called every that applies an arbitrary procedure, 
; given as an argument, to each word of an argument sentence. 
; This procedure is used as follows:
; > (every square ’(1 2 3 4))
; (1 4 9 16)
; > (every first ’(nowhere man))
; (n m)

(define (every f sent)
  (if (empty? sent)
    '()
    (sentence
     (f (first sent))
     (every f (bf sent)))))

; tests
(every square '(1 2 3 4))
(every first '(nowhere man))
