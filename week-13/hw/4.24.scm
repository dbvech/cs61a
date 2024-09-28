(append! primitive-procedures (list (list '< <)))

(set! the-global-environment (setup-environment))

;; inefficient fib calc example
(mc-eval '(define (fib n)
            (if (< n 2)
              n
              (+ (fib (- n 1)) (fib (- n 2)))))
         the-global-environment)

(define result (mc-eval '(fib 27) the-global-environment))

(display "Done: ")
(display result)
(newline)

;; Calc fib 27
;; time stk -I ../../cs61a/lib -l mceval.scm -f 4.24.scm
;; 1 pass - 7.147s total
;; 2 pass - 6.865s total
;; 3 pass - 6.901s total

;; time stk -I ../../cs61a/lib -l analyze.scm -f 4.24.scm
;; 1 pass - 4.369s total
;; 2 pass - 3.947s total
;; 3 pass - 4.371s total

;; Conclusion: the mceval version of evaluator (w/out analyze proc) spents
;; almost HALF of the time on analyzing.
