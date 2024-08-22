(define (scheme-1)
  (newline)
  (display "Scheme-1: ")
  (print (eval-1 (read)))
  (scheme-1))

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
    ((map-exp? exp) (map-1 (eval-1 (cadr exp))
                           (eval-1 (caddr exp))))
    ((let-exp? exp)
     (let ((body (caddr exp))
           (assignment-pairs (cadr exp)))
       (eval-1 (substitute body
                           (map car assignment-pairs)
                           (map eval-1 (map cadr assignment-pairs))
                           '()))))
    ((lambda-exp? exp) exp)
    ((define-exp? exp)
     (eval (list 'define (cadr exp) (maybe-quote (eval-1 (caddr exp))))))
    ((pair? exp) (apply-1 (eval-1 (car exp)) ; eval the operator
                          (map eval-1 (cdr exp))))
    (else (error "bad expr: " exp))))

(define (map-1 proc args)
  (if (null? args)
    '()
    (cons (apply-1 proc (list (car args)))
          (map-1 proc (cdr args)))))

(define (apply-1 proc args)
  (cond ((procedure? proc) ; use underlying Scheme's APPLY
                           (apply proc args))
    ((lambda-exp? proc)
     (eval-1 (substitute (caddr proc) ; the body
                         (cadr proc) ; the formal parameters
                         args ; the actual arguments
                         '()))) ; bound-vars, see below
    (else (error "bad proc: " proc))))

(define (constant? exp)
  (or (number? exp) (boolean? exp) (string? exp) (procedure? exp)))

(define (exp-checker type)
  (lambda (exp) (and (pair? exp) (eq? (car exp) type))))

(define quote-exp? (exp-checker 'quote))
(define if-exp? (exp-checker 'if))
(define lambda-exp? (exp-checker 'lambda))
(define define-exp? (exp-checker 'define))
(define and-exp? (exp-checker 'and))
(define map-exp? (exp-checker 'map))
(define let-exp? (exp-checker 'let))

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

(scheme-1)
