(define (analyze-sequence exps)
  (define (sequentially proc1 proc2)
    (lambda (env) (proc1 env) (proc2 env)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
      first-proc
      (loop (sequentially first-proc
                          (car rest-procs))
        (cdr rest-procs))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
      (error "Empty sequence: ANALYZE"))
    (loop (car procs) (cdr procs))))

;; here if we call (lambda (x))

(define (analyze-sequence exps)
  (define (execute-sequence procs env)
    (cond ((null? (cdr procs))
           ((car procs) env))
          (else ((car procs) env)
                (execute-sequence
                 (cdr procs) env))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
      (error "Empty sequence: 
                ANALYZE"))
    (lambda (env)
            (execute-sequence procs env))))

;; 1. suppose we analyzing the expression 
;; (lambda (x) (* x x))

;; text version of analyze-sequence:
;; analyzes the sub-expression (* x x) and returns the analyzed version

;; Alyssa's version of analyze-sequence:
;; analyzes the sub-expression (* x x) and returns lambda which (when will 
;; be invoked) invokes the procedure execute-sequence which loops through 
;; all expressions (single in this case - (* x x)) in the body of procedure 
;; beeing analyzed.

;; 2. suppose we analyzing the expression 
;; (lambda (x) (do-something) (* x x))

;; text version of analyze-sequence:
;; analyzes all sub-expressions (do-something) and (* x x) and returns
;; single lambda (the result of running sequentially procedure) which
;; runs two analyzed procs in sequence.

;; Alyssa's version of analyze-sequence:
;; analyzes all sub-expressions (do-something) and (* x x) and
;; returns lambda which (when will be invoked) invokes the procedure
;; execute-sequence which loops through all expressions (single in this 
;; case - (* x x)) in the body of procedure beeing analyzed.

;; Conclusion: there are LESS (execution time) operations in text book version
;; of analyze-sequence procedure. Alyssa's version of it will do more stuff
;; in loop (null? checks, etc...) when analyzed procedure will be executing.

