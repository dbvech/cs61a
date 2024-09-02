(define (assoc key records)
  (cond ((null? records) false)
    ((equal? key (caar records))
     (car records))
    (else (assoc key (cdr records)))))

(define (make-table)
  (list '*table*))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
      (set-cdr! record value)
      (set-cdr! table
                (cons (cons key value)
                      (cdr table)))))
  'ok)

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
      (cdr record)
      false)))


(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
            (let ((previously-computed-result
                   (lookup x table)))
              (or previously-computed-result
                  (let ((result (f x)))
                    (insert! x result table)
                    result))))))


(define memo-fib
  (memoize
   (lambda (n)
           (cond ((= n 0) 0)
             ((= n 1) 1)
             (else
              (+ (memo-fib (- n 1))
                 (memo-fib (- n 2))))))))

(trace memo-fib)

;; (memo-fib 3) ; 5 steps
;; (memo-fib 4) ; 7 steps
;; (memo-fib 10) ; 19 steps


;; QUESTION: Explain why memo-fib computes the nth Fibonacci number in a number of steps proportional to n. 

;; ANSWER: 
;; the number of steps to calc fib of n-th number is (n - 1) * 2 + 1
;; EXPLANATION:
;; example step by step evaluation of (memo-fib 5) 
;; (I will replace memo-fib with mf here to save some space)
;;                                              -----(mf 5)---------- 
;;                                             /                     \ 
;;                                     ----(mf 4)----               (mf 4)<-use memoized value
;;                                    /              \
;;                             ----(mf 3)----      (mf 2)<-use memoized value
;;                            /              \     
;;                     ----(mf 2)----      (mf 1)<-use memoized value     
;;                    /              \
;;    base-case ->(mf 1)           (mf 0)<- base-case

;; memo-fib internally invokes itself recursively for n-1 and n-2 (except base cases - 0 and 1),
;; so, given example: 
;; (memo-fib 5)
;;
;; will add two recursive calls:
;; (memo-fib 4) and (memo-fib 3)
;;
;; for each set of recursive calls scheme FIRSTLY will eval the left call (memo-fib (- n 1)),
;; so for (memo-fib 4) here are two addtional recursive calls:
;; (memo-fib 3) and (memo-fib 2)
;;
;; then for (memo-fib 3) another 2 calls 
;; (memo-fib 2) and (memo-fib 1)
;;
;; for (memo-fib 2):
;; (memo-fib 1) and (memo-fib 0) 

;; those are base cases so there will be no more additional recursive calls here
;; (memo-fib 1) will return 1, (memo-fib 0) is 0, so (memo-fib 2) will return (+ 1 0) which is 1
;; then we "go" one level up to (memo-fib 3) call, we calculated LEFT call (memo-fib 2) for it, so
;; now when we go no RIGHT call which is (memo-fib 1), even though it's a base case, we have memoized value for it
;; table, cause we already calculated it in LEFT hierarchy. Same will be for all other RIGHT calls.
;; So, the total number of memo-fib calls will from N to 2 multiplied by 2 (cause for each call we have 
;; 2 additional recursive calls), plus the initial call
;; (n - 1) * 2 + 1
;; so for (memo-fib 3) it will be (3 - 1) * 2 + 1 = 5 calls
;; for (memo-fib 5) it will be (5 - 1) * 2 + 1 = 9 calls ("picture" with explanations above)
;; therefore, the number of steps to calc fib of N is proportional to N


;; QUESTION: Would the scheme still work if we had simply defined memo-fib to be (memoize fib)?
;; (define (fib n)
;;   (cond ((= n 0) 0)
;;         ((= n 1) 1)
;;         (else (+ (fib (- n 1))
;;                  (fib (- n 2))))))
;;
;; (define memo-fib (memoize fib))

;; ANSWER: (memoize fib) will only store the final result, cause fib internally will be calling itself (not memoized version)
;; so, there this will be not efficient at all
