;; An unsolved problem in number theory concerns the following algorithm 
;; for creating a sequence of positive integers s1, s2, ...

;; Choose s1 to be some positive integer.
;; For n > 1,
;;    if sn is odd, then sn+1 is 3sn + 1;
;;    if sn is even, then sn+1 is sn/2.

;; No matter what starting value is chosen, the sequence always seems to end 
;; with the values 1, 4, 2, 1, 4, 2, 1, ... 
;; However, it is not known if this is always the case.

;; 4a. Write a procedure num-seq that, given a positive integer n as argument, returns the stream of values
;; produced for n by the algorithm just given. For example, (num-seq 7) should return the stream representing
;; the sequence 7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1, 4, 2, 1, ...

(define (num-seq n)
  (define (next x)
    (if (even? x) (/ x 2) (+ (* 3 x) 1)))

  (define s
    (cons-stream n (stream-map next s)))
  s)

(ss (num-seq 7) 30)
;; => (7 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1 4 2 1 4 2 1 4 2 1 4 2 1 4 ...)

;; 4b. Write a procedure seq-length that, given a stream produced by num-seq, returns the number of values
;; that occur in the sequence up to and including the first 1. For example, (seq-length (num-seq 7)) should
;; return 17. You should assume that there is a 1 somewhere in the sequence

(define (seq-length s)
  (define (loop s count)
    (if (= (stream-car s) 1)
      (+ count 1)
      (loop (stream-cdr s) (+ count 1))))
  (loop s 0))

(seq-length (num-seq 7))
;; => 17
