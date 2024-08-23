;; Simple evaluator for Scheme without DEFINE, using substitution model.
;; Version 1: No DEFINE, only primitive names are global.

;; The "read-eval-print loop" (REPL):

(define (scheme-1)
  ;; (flush)
  (display "Scheme-1: ")
  (print (eval-1 (read)))
  (scheme-1))

;; Two important procedures:
;; EVAL-1 takes an expression and returns its value.
;; APPLY-1 takes a procedure and a list of actual argument values, and
;;  calls the procedure.
;; They have these names to avoid conflict with STk's EVAL and APPLY,
;;  which have similar meanings.

;; Comments on EVAL-1:

;; There are four basic expression types in Scheme:
;;    1. self-evaluating (a/k/a constant) expressions: numbers, #t, etc.
;;    2. symbols (variables)
;;    3. special forms (in this evaluator, just QUOTE, IF, and LAMBDA)
;;    4. procedure calls (can call a primitive or a LAMBDA-generated procedure)

;; 1.  The value of a constant is itself.  Unlike real Scheme, an STk
;; procedure is here considered a constant expression.  You can't type in
;; procedure values, but the value of a global variable can be a procedure,
;; and that value might get substituted for a parameter in the body of a
;; higher-order function such as MAP, so the evaluator has to be ready to
;; see a built-in procedure as an "expression."  Therefore, the procedure
;; CONSTANT? includes a check for (PROCEDURE? EXP).

;; 2.  In the substitution model, we should never actually evaluate a *local*
;; variable name, because we should have substituted the actual value for
;; the parameter name before evaluating the procedure body.

;; In this simple evaluator, there is no DEFINE, and so the only *global*
;; symbols are the ones representing primitive procedures.  We cheat a little
;; by using STk's EVAL to get the values of these variables.

;; 3.  The value of the expression (QUOTE FOO) is FOO -- the second element of
;; the expression.

;; To evaluate the expression (IF A B C) we first evaluate A; then, if A is
;; true, we evaluate B; if A is false, we evaluate C.

;; The value of a LAMBDA expression is the expression itself.  There is no
;; work to do until we actually call the procedure.  (This won't be true
;; when we write a more realistic interpreter that handles more Scheme
;; features, but it works in the substitution model.)

;; 4.  To evaluate a procedure call, we recursively evaluate all the
;; subexpressions.  We call APPLY-1 to handle the actual procedure invocation.

(define (eval-1 exp)
  (cond ((constant? exp) exp)
    ((symbol? exp) (eval exp (interaction-environment))) ; use underlying Scheme's EVAL
    ((quote-exp? exp) (cadr exp))
    ((if-exp? exp)
     (if (eval-1 (cadr exp))
       (eval-1 (caddr exp))
       (eval-1 (cadddr exp))))
    ((and-exp? exp)
     (cond
       ((null? (cdr exp)) #t)
       ((not (eval-1 (cadr exp))) #f)
       (else (eval-1 (cons (car exp) (cddr exp))))))
    ((lambda-exp? exp) exp)
    ((define-exp? exp)
     (eval (list 'define (cadr exp) (maybe-quote (eval-1 (caddr exp))))))
    ((pair? exp) (apply-1 (eval-1 (car exp)) ; eval the operator
                          (map eval-1 (cdr exp))))
    (else (error "bad expr: " exp))))


;; Comments on APPLY-1:

;; There are two kinds of procedures: primitive and LAMBDA-created.

;; We recognize a primitive procedure using the PROCEDURE? predicate in
;; the underlying STk interpreter.

;; If the procedure isn't primitive, then it must be LAMBDA-created.
;; In this interpreter (but not in later, more realistic ones), the value
;; of a LAMBDA expression is the expression itself.  So (CADR PROC) is
;; the formal parameter list, and (CADDR PROC) is the expression in the
;; procedure body.

;; To call the procedure, we must substitute the actual arguments for
;; the formal parameters in the body; the result of this substitution is
;; an expression which we can then evaluate with EVAL-1.

(define (apply-1 proc args)
  (cond ((procedure? proc) ; use underlying Scheme's APPLY
                           (apply proc args))
    ((lambda-exp? proc)
     (eval-1 (substitute (caddr proc) ; the body
                         (cadr proc) ; the formal parameters
                         args ; the actual arguments
                         '()))) ; bound-vars, see below
    (else (error "bad proc: " proc))))


;; Some trivial helper procedures:

(define (constant? exp)
  (or (number? exp) (boolean? exp) (string? exp) (procedure? exp)))

(define (exp-checker type)
  (lambda (exp) (and (pair? exp) (eq? (car exp) type))))

(define quote-exp? (exp-checker 'quote))
(define if-exp? (exp-checker 'if))
(define lambda-exp? (exp-checker 'lambda))
(define define-exp? (exp-checker 'define))


;; SUBSTITUTE substitutes actual arguments for *free* references to the
;; corresponding formal parameters.  For example, given the expression
;;
;;	((lambda (x y)
;;	   ((lambda (x) (+ x y))
;;	    (* x y)))
;;	 5 8)
;;
;; the body of the procedure we're calling is
;;
;;	   ((lambda (x) (+ x y))
;;	    (* x y))
;;
;; and we want to substitute 5 for X and 8 for Y, but the result should be
;;
;;	   ((lambda (x) (+ x 8))
;;	    (* 5 8))
;;
;; and *NOT*
;;
;;	   ((lambda (5) (+ 5 8))
;;	    (* 5 8))
;;
;; The X in (* X Y) is a "free reference," but the X in (LAMBDA (X) (+ X Y))
;; is a "bound reference."
;;
;; To make this work, in its recursive calls, SUBSTITUTE keeps a list of
;; bound variables in the current subexpression -- ones that shouldn't be
;; substituted for -- in its argument BOUND.  This argument is the empty
;; list in the top-level call to SUBSTITUTE from APPLY-1.

;; Another complication is that when an argument value isn't a self-evaluating
;; expression, we actually want to substitute the value *quoted*.  For example,
;; consider the expression
;;
;;	((lambda (x) (first x)) 'foo)
;;
;; The actual argument value is FOO, but we want the result of the
;; substitution to be
;;
;;	(first 'foo)
;;
;; and not
;;
;;	(first foo)
;;
;; because what we're going to do with this expression is try to evaluate
;; it, and FOO would be an unbound variable.

;; There is a strangeness in MAYBE-QUOTE, which must handle the
;; case of a primitive procedure as the actual argument value; these
;; procedures shouldn't be quoted.

(define (substitute exp params args bound)
  (cond ((constant? exp) exp)
    ((symbol? exp)
     (if (memq exp bound)
       exp
       (lookup exp params args)))
    ((quote-exp? exp) exp)
    ((lambda-exp? exp)
     (list 'lambda
           (cadr exp)
           (substitute (caddr exp) params args (append bound (cadr exp)))))
    (else (map (lambda (subexp) (substitute subexp params args bound))
               exp))))

(define (lookup name params args)
  (cond ((null? params) name)
    ((eq? name (car params)) (maybe-quote (car args)))
    (else (lookup name (cdr params) (cdr args)))))

(define (maybe-quote value)
  (cond ((lambda-exp? value) value)
    ((constant? value) value)
    ((procedure? value) value) ; real Scheme primitive procedure
    (else (list 'quote value))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Sample evaluation, computing factorial of 5:

; Scheme-1: ((lambda (n)
;	       ((lambda (f) (f f n))
;		(lambda (f n)
;		   (if (= n 0)
;		       1
;		       (* n (f f (- n 1))) )) ))
;	     5)
; 120

;; Sample evaluation, using a primitive as argument to MAP:

; Scheme-1: ((lambda (f n)
;	       ((lambda (map) (map map f n))
;		   (lambda (map f n)
;		     (if (null? n)
;		         '()
;			 (cons (f (car n)) (map map f (cdr n))) )) ))
;	      first
;	      '(the rain in spain))
; (t r i s)

;;  1a.
;;  1. the whole exprassion will be passed to eval-0 procedure
;;  2. it satisfies condition (pair? exp) so it will execute this clause
;;     (apply-0 (car exp) (map eval-0 (cdr exp)))
;;  3. it will map through (cdr exp), which in our case is number 5, and invoke eval-0 for it
;;  4. eval-0 for 5 will return 5
;;  5. next it will pass (car exp) (which is lambda expression) and list (5) as args to apply-0 procedure
;;     (apply-0 (lambda (x) (+ x 3)) (5))
;;  6. the exp (lambda (x) (+ x 3)) satisfies lambda-exp? predicate so it will execute following:
;;     (eval-0 (substitute (+ x 3) (x) (5), '()))    
;;  7. substitute procedure will replace each x -> 5 in the body (+ x 3) so it will return (+ 5 3)
;;     (eval-0 (+ 5 3))
;;  8. (+ 5 3) inside eval-0 satisfies predicate pair? so it will execute
;;     (apply-0 (car (+ 5 3)) (map eval-0 (cdr (+ 5 3))))
;;  9. (map eval-0 (cdr (+ 5 3))) will return the list (5 3) cause each list item is satisfies 
;;     constant? predicate, so in result there will be this:
;;     (apply-0 + (5 3)) 
;; 10. inside apply-0, the formal parameter proc (with actual arg +) will satisfy predicate symbol? so 
;;     it will use underlying Scheme's EVAL and APPLY
;;     (apply (eval +) (5 3))
;; 11. (eval +) will return pointer to + procedure from scheme so we will have:
;;     (apply + (5 3))  note plus sign here is not just a symbol already, it is actual pointer to procedure +
;; 12. apply will invoke + procedure with args 5 and 3 like so (+ 5 3) so result (and the output) will be 8


;; 1b.
;; Filter procedure is invented here
;; ((lambda (pred? n)
;;          ((lambda (filter) (filter filter pred? n))
;;           (lambda (filter pred? n)
;;                   (if (null? n)
;;                     '()
;;                     (if (pred? (car n))
;;                       (cons (car n) (filter filter pred? (cdr n)))
;;                       (filter filter pred? (cdr n)))))))
;;  even?
;;  '(1 2 3 4 5 6 7))

;; 1c.
;; (map first '(the rain in spain)) 
;; this one is working cause `first` is evaluated to actual scheme procedure

;; (map (lambda (x) (first x)) '(the rain in spain))
;; this one isn't working cause (lambda (x) (first x)) is not evaluating to become an
;; actual procedure instead it self-evaluates by eval-1

;; 1d.
(define and-exp? (exp-checker 'and))
;; tests
;; (and #f abracadabra) <- returns #f without evaluating "abracadabra" (would be error in other case)
;; (and #t abracadabra) <- false with error as it tries to evaluate 2nd arg and it is unbound variable