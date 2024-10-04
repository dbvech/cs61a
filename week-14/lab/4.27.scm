(define count 0)
(define (id x) (set! count (+ count 1)) x)

;; Give the missing values in the following sequence of interactions, 
;; and explain your answers.

(define w (id (id 10)))

;; the interpreter will assign the result of 
;; (eval '(id (id 10))) exp to var "w"
;; -> inside eval
;; (apply (actual-value 'id env)
;;        '((id 10)) <- operands 
;;        env)
;; -> inside apply
;; (eval-sequence
;;   '((set! count (+ count 1)) x)
;;   (extend-environment
;;     '(x)
;;     (list-of-delayed-args '((id 10)) env) ; changed
;;     (procedure-environment procedure))))
;; -> inside eval-sequence
;;      (cond ((last-exp? '((set! count (+ count 1)) x)) 
;;                  (eval (first-exp '((set! count (+ count 1)) x)) env))
;;            (else (eval (first-exp '((set! count (+ count 1)) x)) env)
;;                  (eval-sequence (rest-exps '((set! count (+ count 1)) x)) env))))
;; ---> (eval-assignment '(set! count (+ count 1)))
;;        (set-variable-value! 'count
;;                             (eval (+ count 1) env)
;;                             env)
;; ------> (eval (+ count 1))
;;           (apply (actual-value '+ env)
;;                	    '(count 1)
;;                	    env))
;; ---------> (apply '(+ [ref-to +]) '(count 1) env)
;;              (apply-primitive-procedure
;;                '(+ [ref-to +])
;;                (list-of-arg-values '(count 1) env)))
;; ------------> (apply-primitive-procedure '(+ [ref-to +]) '(0 1) env)
;;                (apply-in-underlying-scheme
;;                 (primitive-implementation '(+ [ref-to +])) '(0 1)))
;;                ^ this would invoke Scheme's origin "apply" procedure 
;;                  which will apply + to arguments '(0 1)
;; <------------ 1
;; ---> back to (eval-assignment '(set! count (+ count 1)))
;;        (set-variable-value! 'count
;;                             1 <- result from previous
;;                             env)
;;         ^ here we assign 1 to variable count
;; -> back to eval-sequence (recursive call)
;; (cond ((last-exp? '(x)) 
;;             (eval (first-exp '(x)) env))
;;       (else (eval (first-exp '(x)) env)
;;             (eval-sequence (rest-exps '(x)) env))))
;; ---> (eval 'x env)
;; <--- would return the value of "x" which is thunk (id 10)
;;
;; THUS, at this point we have count changed to 1

;;; L-Eval input:
count

;;; L-Eval value:
1 ; (explanation above)

;;; L-Eval input:
w
;; the value of "w" at this point is the thunk (id 10), it will be return
;; from eval procedure. In driver-loop this think will be passed to 
;; actual-value proc which will force-it. (id 10) will next value (2) to count var
;; AND will return 10 as value of "w".

;;; L-Eval value:
10 ; explanation above

;;; L-Eval input:
count

;;; L-Eval value:
2 ; explanation above
