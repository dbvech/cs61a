;; Give all possible values of x that can result from executing

(define x 10)
(parallel-execute
 (lambda () (set! x (* x x)))
 (lambda () (set! x (* x x x))))

;; correct result
;; 1 000 000: x^2 completely then x^3 completely 
;;            OR x^3 completely then x^2 completely

;; all other results are incorrect:
;;       100: x^2 reads x, x^3 runs completely, then x^2 sets 100
;;     1 000: x^3 reads x, x^2 runs completely, then x^3 sets 1 000
;;    10 000: x^2 reads 1st x, then x^3 runs completely, 
;;            then x^2 reads 2nd x and sets 10 000
;;            OR
;;            x^3 reads 1st and 2nd x, then x^2 runs completely, 
;;            then x^3 reads 3rd x which results to 10 * 10 * 100
;;   100 000: x^3 reads 1st x, then x^2 runs completely, 
;;            then x^3 reads 2nd which results to 10 * 100 * 100

;; Which of these possibilities remain if we instead use serialized procedures:

(define x 10)
(define s (make-serializer))

(parallel-execute
 (s (lambda () (set! x (* x x))))
 (s (lambda () (set! x (* x x x)))))

;; since we serialize the the whole read-write processes, we can be sure
;; only one of those serialized procedures will be invoked at once, so
;; only correct answer will left which is:
;; 1 000 000: x^2 completely then x^3 completely 
;;            OR x^3 completely then x^2 completely
