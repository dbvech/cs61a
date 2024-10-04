;; Any program that matches the following criteria will be much slower:
;; - it uses some of it's arguments repeatedly
;; - evaluating of this argument is expensive
;; Example:
(define (add-n-times x n)
  (if (= n 0)
    0
    (+ x (add-n-times x (- n 1)))))

(add-n-times (factorial 50) 200)

;; --- 
(define (square x) (* x x))

;;; L-Eval input:
(square (id 10))

;;; L-Eval value:
100 ; in both scenarios

;;; L-Eval input:
count

;;; L-Eval value:
2 ; w/out memo, cause "x" would hold thunk to evaluate (id x), a we access "x"
  ; 2 times here (* x x), so "count" would be incremented 2 times

1 ; w/ memo, cause (id x) would be evaluated only once on first read here (* x x)
  ; on second read it wil return cached result
