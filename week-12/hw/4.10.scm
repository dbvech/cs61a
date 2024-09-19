;; I will introduce a new syntax for lambdas - arrow syntax

;; As an example we can take this multiply procedure:
;; (lambda (a b) (* a b))

;; and write it in arrow syntax:
;; ((a b) => (* a b))

;; so we can omit word "lambda", but need to add arrow =>
;; between formal parameters and body.

;; Implementation:

;; 1. Change the lambda? predicate
(define (lambda? exp)
  (or (tagged-list? exp 'lambda)
      (eq? (cadr exp) '=>)))

;; 2. Add new predicate arrow-lambda?
(define (arrow-lambda? exp) (eq? (cadr exp) '=>))

;; 3. Change selectors lambda-parameters and lambda-body
(define (lambda-parameters exp)
  (if (arrow-lambda? exp)
    (car exp)
    (cadr exp)))

(define (lambda-body exp)
  (cddr exp))

