;;; logo-meta.scm      Part of programming project #4

;;; Differences between the book and this version:  Eval and apply have
;;; been changed to logo-eval and logo-apply so as not to overwrite the Scheme
;;; versions of these routines. An extra procedure initialize-logo has been
;;; added. This routine resets the global environment and then executes the
;;; driver loop. This procedure should be invoked to start the Logo
;;; evaluator executing.  Note: It will reset your global environment and all
;;; definitions to the Logo interpreter will be lost. To restart the Logo
;;; interpreter without resetting the global environment, just invoke
;;; driver-loop.  Don't forget that typing control-C will get you out of
;;; the Logo evaluator back into Scheme.

;;; Problems A1, A2, and B2 are entirely in logo.scm
;;; Problems A3, B3, and 6 require you to find and change existing procedures.

;;;  Procedures that you must write from scratch:

;;; Problem B1    eval-line

(define (eval-line line-obj env)
  (let ((result (logo-eval line-obj env)))
    (cond 
      ((not (eq? result '=no-value=)) result)
      ((ask line-obj 'empty?) '=no-value=)
      (else (eval-line line-obj env)))))


;;; Problem B3    variables  (other procedures must be modified, too)
;;; data abstraction procedures

(define (variable? exp)
  (equal? (first exp) ":"))

(define (variable-name exp)
  (bf exp))


;;; Problem A4   handle-infix

(define (de-infix token)
  (cdr (assoc token '((+ . sum)
		      (- . difference)
		      (* . product)
		      (/ . quotient)
		      (= . equalp)
		      (< . lessp)
		      (> . greaterp)))))

(define (handle-infix value line-obj env)
  (define (check-infix)
    (let ((next-token (ask line-obj 'next)))
      (if (member? next-token '(+ - * / = < >))
	(de-infix next-token)
	(begin
	  (ask line-obj 'put-back next-token)
	  #f))))
  (if (ask line-obj 'empty?)
    value
    (let ((infix-proc (check-infix)))
      (if (not infix-proc)
	value
	(let ((result 
		(eval-prefix 
		  (make-line-obj (list infix-proc value (ask line-obj 'next))) 
		  env))) 
	  (handle-infix result line-obj env))))))

;;; Problem B4    eval-definition

(define (eval-definition line-obj)
  (define (read-body body)
    (prompt "-> ")
    (let ((line (logo-read)))
      (if (equal? (car line) "end")
	body
	(read-body (append body (list line))))))
  (define (get-formals)
    (if (ask line-obj 'empty?)
      '()
      (let ((next (ask line-obj 'next)))
	(if (eq? next 'static)
	  '()
	  (cons (bf next) (get-formals))))))
  (define (get-static-vars frame)
    (if (ask line-obj 'empty?)
      frame
      (let ((var (bf (ask line-obj 'next)))
	    (val (logo-eval line-obj the-global-environment)))
	(add-binding-to-frame! var val frame)
	(get-static-vars frame))))
  (let ((name (ask line-obj 'next))
	(formals (get-formals))
	(static-vars (get-static-vars (make-frame '() '())))
	(body (read-body '())))
    (set! the-procedures 
      (cons 
	(list name 'compound (length formals) (cons formals body) #f static-vars)
	the-procedures)))
  '=no-value=)

;;; Problem 5    eval-sequence

(define (eval-sequence exps env step?)
  (if (empty? exps) 
    '=no-value=
    (begin
      (if step? (begin 
		  (display (car exps))
		  (prompt ">>> ")
		  (logo-read)))
      (let ((result (eval-line (make-line-obj (car exps)) env)))
	(cond
	  ((eq? result '=stop=) '=no-value)
	  ((and (list? result) 
		(eq? (car result) '=output=)) 
	   (cdr result))
	  ((eq? result '=no-value=) (eval-sequence (cdr exps) env step?))
	  (else (error "You don't say what to do with " result)))))))



;;; SETTING UP THE ENVIRONMENT

(define the-primitive-procedures '())

(define (add-prim name count proc)
  (set! the-primitive-procedures
	(cons (list name 'primitive count proc)
	      the-primitive-procedures)))

(add-prim 'first 1 first)
(add-prim 'butfirst 1 bf)
(add-prim 'bf 1 bf)
(add-prim 'last 1 last)
(add-prim 'butlast 1 bl)
(add-prim 'bl 1 bl)
(add-prim 'word -2 word)
(add-prim 'sentence -2 se)
(add-prim 'se -2 se)
(add-prim 'list -2 list)
(add-prim 'fput 2 cons)

(add-prim 'sum -2 (make-logo-arith +))
(add-prim 'difference 2 (make-logo-arith -))
(add-prim '=unary-minus= 1 (make-logo-arith -))
(add-prim '- 1 (make-logo-arith -))
(add-prim 'product -2 (make-logo-arith *))
(add-prim 'quotient 2 (make-logo-arith /))
(add-prim 'remainder 2 (make-logo-arith remainder))

(add-prim 'print 1 logo-print)
(add-prim 'pr 1 logo-print)
(add-prim 'show 1 logo-show)
(add-prim 'type 1 logo-type)
(add-prim 'make '(2) make)

(add-prim 'run '(1) run)
(add-prim 'if '(2) logo-if)
(add-prim 'ifelse '(3) ifelse)
(add-prim 'equalp 2 (logo-pred (make-logo-arith equalp)))
(add-prim 'lessp 2 (logo-pred (make-logo-arith <)))
(add-prim 'greaterp 2 (logo-pred (make-logo-arith >)))
(add-prim 'emptyp 1 (logo-pred empty?))
(add-prim 'numberp 1 (logo-pred (make-logo-arith number?)))
(add-prim 'listp 1 (logo-pred list?))
(add-prim 'wordp 1 (logo-pred (lambda (x) (not (list? x)))))

(add-prim 'stop 0 (lambda () '=stop=))
(add-prim 'output 1 (lambda (x) (cons '=output= x)))
(add-prim 'op 1 (lambda (x) (cons '=output= x)))

(add-prim 'load 1 meta-load)

(define (set-debug-flag-wrapper flag)
  (lambda (proc-name) 
    (let ((proc (lookup-procedure proc-name)))
      (if (not proc)
	(error "Not defined procedure " proc-name)
	(if (not (compound-procedure? proc))
	  (error "Not compound procedure " proc-name)
	  (begin 
	    (set-debug-flag! proc flag)
	    '=no-value=))))))

(add-prim 'step 1 (set-debug-flag-wrapper #t))
(add-prim 'unstep 1 (set-debug-flag-wrapper #f))

(define (logo-test env t/f)
  (cond
    ((eq? t/f 'true) 
     (define-variable! '*=test=* #t env)
     '=no-value=)
    ((eq? t/f 'false) 
     (define-variable! '*=test=* #f env)
     '=no-value=)
    (else 
      (error "The argument to TEST must be TRUE of FALSE"))))

(define (logo-if-true env arg)
  (let ((test-binding (lookup-variable-binding '*=test=* env)))
    (cond
      ((null? test-binding) (error "No TEST was used before"))
      ((cdr test-binding) (eval-line (make-line-obj arg) env))
      (else '=no-value=))))

(define (logo-if-false env arg)
  (let ((test-binding (lookup-variable-binding '*=test=* env)))
    (cond
      ((null? test-binding) (error "No TEST was used before"))
      ((not (cdr test-binding)) (eval-line (make-line-obj arg) env))
      (else '=no-value=))))

(add-prim 'test '(1) logo-test)
(add-prim 'iftrue '(1) logo-if-true)
(add-prim 'ift'(1) logo-if-true)
(add-prim 'iffalse '(1) logo-if-false)
(add-prim 'iff'(1) logo-if-false)

(define the-global-environment '())
(define the-procedures the-primitive-procedures)

;;; INITIALIZATION AND DRIVER LOOP

;;; The following code initializes the machine and starts the Logo
;;; system.  You should not call it very often, because it will clobber
;;; the global environment, and you will lose any definitions you have
;;; accumulated.

(define (initialize-logo)
  (set! the-global-environment (extend-environment '() '() '()))
  (set! the-procedures the-primitive-procedures)
  (driver-loop))

(define (driver-loop)
  (define (helper)
    (prompt "? ")
    (let ((line (logo-read)))
      (if (not (null? line))
  	  (let ((result (eval-line (make-line-obj line)
				   the-global-environment)))
	    (if (not (eq? result '=no-value=))
		(logo-print (list "You don't say what to do with" result))))))
    (helper))
  (logo-read)
  (helper))

;;; APPLYING PRIMITIVE PROCEDURES

;;; To apply a primitive procedure, we ask the underlying Scheme system
;;; to perform the application.  (Of course, an implementation on a
;;; low-level machine would perform the application in some other way.)

(define (apply-primitive-procedure p args)
  (apply (text p) args))


;;; Now for the code that's based on the book!!!


;;; Section 4.1.1

;; Given an expression like (proc :a :b :c)+5
;; logo-eval calls eval-prefix for the part in parentheses, and then
;; handle-infix to check for and process the infix arithmetic.
;; Eval-prefix is comparable to Scheme's eval.

(define (logo-eval line-obj env)
  (handle-infix (eval-prefix line-obj env) line-obj env))

(define (eval-prefix line-obj env)
  (define (eval-helper paren-flag)
    (define (get-proc-args proc)
      (let ((argc (arg-count proc)))
	(cond
	  ((list? argc)
	   (cons env (collect-n-args (car argc) line-obj env)))
	  ((< argc 0)
	   (collect-n-args (if paren-flag argc (abs argc)) line-obj env))
	  (else
	    (collect-n-args (arg-count proc) line-obj env)))))
    (let ((token (ask line-obj 'next)))
      (cond ((self-evaluating? token) token)
            ((variable? token)
	     (lookup-variable-value (variable-name token) env))
            ((quoted? token) (text-of-quotation token))
            ((definition? token) (eval-definition line-obj))
	    ((left-paren? token)
	     (let ((result (handle-infix (eval-helper #t)
				       	 line-obj
				       	 env)))
	       (let ((token (ask line-obj 'next)))
	       	 (if (right-paren? token)
		     result
		     (error "Too much inside parens")))))
	    ((right-paren? token)
	     (error "Unexpected ')'"))
            (else
	     (let ((proc (lookup-procedure token)))
	       (if (not proc) (error "I don't know how to" token))
	       (logo-apply proc (get-proc-args proc) env))) )))
  (eval-helper #f))

(define (logo-apply procedure arguments env)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure procedure arguments))
        ((compound-procedure? procedure)
         (eval-sequence (procedure-body procedure)
			(cons (static-frame procedure) 
			      (extend-environment 
				(parameters procedure) 
				arguments 
				env))
			(debug-enabled? procedure)))
        (else
         (error "Unknown procedure type -- LOGO-APPLY" procedure))))

(define (collect-n-args n line-obj env)
  (cond ((= n 0) '())
	((and (< n 0) (not (ask line-obj 'empty?)))
	 (let ((token (ask line-obj 'next)))
	   (ask line-obj 'put-back token)
	   (if (right-paren? token)
	       '()
      	       (let ((next (logo-eval line-obj env)))
        	 (cons next
	      	       (collect-n-args (-1+ n) line-obj env)) ))))
	(else      
      	 (let ((next (logo-eval line-obj env)))
           (cons next
	      	 (collect-n-args (-1+ n) line-obj env)) ))))

;;; Section 4.1.2 -- Representing expressions

;;; numbers

(define (self-evaluating? exp) (number? exp))

;;; quote

(define (quoted? exp)
  (or (list? exp)
      (eq? (string-ref (word->string (first exp)) 0) #\")))

(define (text-of-quotation exp)
  (if (list? exp)
      exp
      (bf exp)))

;;; parens

(define (left-paren? exp) (eq? exp left-paren-symbol))

(define (right-paren? exp) (eq? exp right-paren-symbol))

;;; definitions

(define (definition? exp)
  (eq? exp 'to))

;;; procedures

(define (lookup-procedure name)
  (assoc name the-procedures))

(define (primitive-procedure? p)
  (eq? (cadr p) 'primitive))

(define (compound-procedure? p)
  (eq? (cadr p) 'compound))

(define (arg-count proc)
  (caddr proc))

(define (text proc)
  (cadddr proc))

(define (debug-enabled? proc) 
  (cadr (cdddr proc)))

(define (static-frame proc) 
  (caddr (cdddr proc)))

(define (set-debug-flag! proc flag) 
  (set-car! (cdr (cdddr proc)) flag))

(define (parameters proc) (car (text proc)))

(define (procedure-body proc) (cdr (text proc)))

;;; Section 4.1.3

;;; Operations on environments

(define (enclosing-environment env) (cdr env))

(define (first-frame env) (car env))

(define the-empty-environment '())

(define (make-frame variables values)
  (cons variables values))

(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))

(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))

(define (lookup-variable-binding var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (cons var (car vals)))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        '()
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (lookup-variable-value var env)
  (let ((binding (lookup-variable-binding var env)))
    (if (null? binding)
      (error "Unbound variable" var)
      (cdr binding))))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             (add-binding-to-frame! var val frame))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))
