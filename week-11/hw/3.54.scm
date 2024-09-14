;; Define a procedure mul-streams, analogous to add-streams, that produces the 
;; elementwise product of its two input streams. Use this together with the 
;; stream of integers to complete the following definition of the stream whose 
;; nth element (counting from 0) is n+1 factorial:

(define (integers-starting-from n)
  (cons-stream
   n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))

(define (mul-streams s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
               (mul-streams (stream-cdr s1) (stream-cdr s2))))

(define factorials
  (cons-stream 1 (mul-streams integers factorials)))
