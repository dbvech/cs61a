;; eval cond clauses (somewhere after variable? clause AND before )
;; ((variable? exp) ...)
;; ...
((and? exp) (eval-and exp env))
((or? exp) (eval-or exp env))
;; ...
;; ((application? exp) ...)

(define (eval-and exp env)
  (define (loop exps)
    (cond 
      ((no-and-expressions? exps) #t)
      ((no-and-expressions? (rest-and-exp exps)) 
       (mc-eval (first-and-exp exps) env))
      ((true? (mc-eval (first-and-exp exps) env))
       (loop (rest-and-exp exps)))
      (else #f)))
  (loop (and-expressions exp)))

(define (eval-or exp env)
  (define (loop exps)
    (if (no-or-expressions? exps)
      #f
       (let ((value (mc-eval (first-or-exp exps) env)))
         (if (true? value)
           value
           (loop (rest-or-exp exps))))))
  (loop (or-expressions exp)))

;; data abstractions
(define (and? exp) (tagged-list? exp 'and))
(define (and-expressions exp) (cdr exp))
(define (no-and-expressions? exp) (null? exp))
(define (first-and-exp exp) (car exp))
(define (rest-and-exp exp) (cdr exp))

(define (or? exp) (tagged-list? exp 'or))
(define (or-expressions exp) (cdr exp))
(define (no-or-expressions? exp) (null? exp))
(define (first-or-exp exp) (car exp))
(define (rest-or-exp exp) (cdr exp))
