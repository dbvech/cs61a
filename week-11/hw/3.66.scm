(define (integers-starting-from n)
  (cons-stream
   n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))

(define (interleave s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream
     (stream-car s1)
     (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x)
                        (list (stream-car s) x))
                (stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))

(define t (pairs integers integers))

;; here are pairs included in result stream

;;       [1 1] [1 2] [1 3] [1 4] [1 5] [1 6] [1 7] [1 8] [1 9] ...
;;             [2 2] [2 3] [2 4] [2 5] [2 6] [2 7] [2 8] [2 9] ...
;;                   [3 3] [3 4] [3 5] [3 6] [3 7] [3 8] [3 9] ...
;;                         [4 4] [4 5] [4 6] [4 7] [4 8] [4 9] ...
;;                               [5 5] ...........................

;; here are their positions in the stream

;;2^1-2    0     1     3     5     7     9     11    13    15  ...
;;2^2-2          2     4     8     12    16    20    24    28  ...
;;2^3-2                6     10    18    26    34    42    50  ...
;;2^4-2                      14    22    38    54    70    86  ...
;;2^5-2                            30  ...........................

;; Each "row" (1 1) (2 2) (3 3) (n n) starts at position 2^n - 2
;; Example: 4th row will start at position 2^4 - 2 = 14 with element (4 4)
;; each element I of the row N is on the position 
;; - if I = N, then 2^n - 2
;; - if I > N, then 2^n - 2 + (2^n * (I-N) - 2^(n-1))
;; Example: to find which index of pair (4 6)
;; N = 4, I = 6
;; 2^4 - 2 + 2^4 * (6 - 4) - 2^(4-1) = 
;; 16 - 2 + 16 * 2 - 8 = 
;; 14 + 32 - 8 = 38

;; QUESTION: For example, approximately how many pairs precede the pair (1, 100)? 

;; using formula above the location of pair (1 100) is 
;; 2^1 - 2 + 2^1 * (100 - 1) - 2^(1-1) = 
;; 2 - 2 + 2 * 99 - 2^0 = 
;; 198 - 1 = 197
;; so, pair (1, 100) is 197th in the stream (pairs integers integers)
;; which means there are 196 pairs before
;; ANSWER: 196 pairs

;; QUESTION: the pair (99, 100)? 

;; 2^99 - 2 + (2^99 * (100-99) - 2^(99-1)) - 1 (-1 to get number of pairs precede)
;; ANSWER: 2^99*2 - 2^98 - 3 pairs precede the pair (99, 100)

;; QUESTION: the pair (100, 100)? 

;; 2^100 - 2 - 1 (-1 to get number of pairs precede)
;; ANSWER: 2^100 - 3 pairs precede the pair (100, 100)

