;; Since self-evaluating and variable expressions are NOT pairs
;; we cannot tag them (in other case we would need to
;; read variables like this ('var foo) which is verbose), thus
;; clauses "self-evaluating?" and "variable?" should remain here
;; in eval procedure BEFORE special forms
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((special-form? (exp-type exp))
         ((get-handler (exp-type exp)) exp env))
        (else
         (if (application? exp)
           (apply (eval (operator exp) env)
                  (list-of-values (operands exp) env))
           (error "Unknown expression type -- EVAL" exp)))))

;; Special forms table
(define special-forms-table (list '*table*))

(define (special-form? type)
  (if (assoc type (cdr special-forms-table)) #t #f))

(define (get-handler type)
  (let ((record (assoc type (cdr special-forms-table))))
    (if (not record) #f (cdr record))))

(define (put-handler type handler)
  (let ((record (assoc type (cdr special-forms-table))))
    (if record
      (set-cdr! record handler)
      (set-cdr! special-forms-table
                (cons (cons type handler)
                      (cdr special-forms-table))))))

(define exp-type car)

;; Add special forms handlers
(put-handler 'quote text-of-quotation)
(put-handler 'set! eval-assignment)
(put-handler 'define eval-definition)
(put-handler 'if eval-if)
(put-handler 'lambda
             (lambda (exp env)
                     (make-procedure (lambda-parameters exp)
                                     (lambda-body exp)
                                     env)))
(put-handler 'begin
             (lambda (exp env)
                     (eval-sequence (begin-actions exp) env)))
(put-handler 'cond
             (lambda (exp env)
                     (eval (cond->if exp) env)))

(define (text-of-quotation exp env) (cadr exp)) ; here we added env param

