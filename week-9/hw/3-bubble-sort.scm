(define (bubble-sort! vec)
  (define (loop left right)
    (cond
      ((= right 0) vec)
      ((= left right) (loop 0 (- right 1)))
      (else
       (let ((left-val (vector-ref vec left))
             (next-val (vector-ref vec (+ left 1))))
         (if (> left-val next-val)
           (begin
            (vector-set! vec left next-val)
            (vector-set! vec (+ left 1) left-val)))

         (loop (+ left 1) right)))))
  (loop 0 (- (vector-length vec) 1)))


;; (b) Prove that this algorithm really does sort the vector. Hint: Prove the parenthetical claim in step [2]

;; how it works:
;; we have two pointers, which initially points to very first and last elements of vector
;;
;; v       v
;; 5 1 3 2 4
;;
;; on each iteration we check if left pointer (currently points to 5) is greater then next element (left + 1)
;; and if so then swap them 
;; 
;; v       v
;; 1 5 3 2 4
;;
;; then move the left pointer to the right and compare next values:
;;
;;   v     v
;; 1 5 3 2 4
;;
;; 5 > 3, so we swap them and move pointer
;;
;;     v   v
;; 1 3 5 2 4
;; 
;; 5 > 2, swap
;;
;;       v v
;; 1 3 2 5 4
;; 
;; 5 > 4, swap
;;
;;         vv
;; 1 3 2 4 5
;;
;; now two pointers are point to same place, it means that we finished one pass, the GREATEST number (5)
;; is now at the end of vector, so we reset the left pointer back to 0, and shift right pointer to left by one
;; (cause it make no sense sort the last element as it's already sorted)
;;
;; v     v  
;; 1 3 2 4 5
;;
;; now the process starts over:
;;
;; v     v  
;; 1 3 2 4 5 - no swap
;;
;;   v   v  
;; 1 3 2 4 5 - swap 3 with 2
;;
;;     v v  
;; 1 2 3 4 5 - no swap
;;
;;       vv  
;; 1 2 3 4 5 - end of pass, reset
;;
;; v   v
;; 1 2 3 4 5 - no swap
;;
;;   v v
;; 1 2 3 4 5 - no swap
;;
;;     vv
;; 1 2 3 4 5 - end of pass, reset
;;
;; v v   
;; 1 2 3 4 5 - no swap
;;
;;   vv   
;; 1 2 3 4 5 - end of pass
;;
;; now the right pointer is at 0 index so we finish the sorting.
;; vv   
;; 1 2 3 4 5 

;; (c) What is the order of growth of the running time of this algorithm?
;; ANSWER: Theta(N^2). 
