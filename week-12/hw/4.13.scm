;; (make-unbound! VAR) - removes VAR from closest ENV where
;;                       VAR occurs.

;; new cond clause for eval
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ;; ...
        ((make-unbound? exp) (eval-unbound exp env))
        ;; ...
        ))

;; new eval func for unbound expression
(define (eval-unbound exp env)
  (unbound-variable! (unbound-variable-name exp) env)
  'ok)

;; data abstraction for make-unbound expression
(define (make-unbound? exp)
  (tagged-list? exp 'make-unbound!))

(define (unbound-variable-name exp) (cadr exp))

;; procedure that tries to delete VAR starting from given 
;; (current) ENV and up to outer most (global) ENV until 
;; it finds one.
(define (unbound-variable! var env)
  (cond
    ((eq? env the-empty-environment) false)
    ((remove-variable-from-env! var env) true)
    (else (unbound-variable! var (enclosing-environment env)))))

;; procedure to remove VAR from given ENV
(define (remove-variable-from-env! var env)
  (define (remove-after-first! vars values)
    (cond
      ((null? (cdr vars)) false)
      ((eq? var (cadr vars))
       (set-cdr! vars (cddr vars))
       (set-cdr! values (cddr values))
       true)
      (else (remove-after-first! (cdr vars) (cdr values)))))
  (if (eq? env the-empty-environment)
    false
    (let ((frame (first-frame env)))
      (let ((vars (frame-variables frame))
            (values (frame-values frame)))
        (cond
          ((null? vars) false)
          ((eq? var (car vars))
           (set-car! frame (cdr vars))
           (set-cdr! frame (cdr values))
           true)
          (else (remove-after-first! vars values)))))))



