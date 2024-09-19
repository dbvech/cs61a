;; let abstraction
(define (let? exp) (tagged-list? exp 'let))

(define (let-bindings exp) (cadr exp))

(define (let-body exp) (cddr exp))

(define (let->combination exp)
  (cons (make-lambda (map car (let-bindings exp))
                     (let-body exp))
        (map cadr (let-bindings exp))))

;; new cond clause for eval
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ;; ...
        ((let? exp) (eval (let->combination exp) env))
        ;; ...
        ))



