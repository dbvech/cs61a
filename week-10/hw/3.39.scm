;; Which of the five possibilities in the parallel execution shown above remain if we instead serialize execution as follows:

(define x 10)
(define s (make-serializer))

(parallel-execute
 (lambda () (set! x ((s (lambda () (* x x))))))
 (s (lambda () (set! x (+ x 1)))))

;; The following result is now not possible:

;; 110: P2 changes x from 10 to 11 between the two times that P1 accesses 
;; the value of x during the evaluation of (* x x).

;; because complutational part of P2 is now serialized, there is no way to
;; that x is changed between the two times that P1 accesses the value of x.

;; The following possibilities remain:

;; 101: P1 sets x to 100 and then P2 increments x to 101.
;; 121: P2 increments x to 11 and then P1 sets x to x times x.
;;  11: P2 accesses x, then P1 sets x to 100, then P2 sets x.
;; 100: P1 accesses x (twice), then P2 sets x to 11, then P1 sets x.
