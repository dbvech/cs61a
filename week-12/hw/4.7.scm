;; We can iterate through bindings list and for each list create new
;; let expression (new proc make-let) with body:
;; - if there are other bindings, then expand them recursively and use 
;;   result as body
;; - if there are no other bindings, then use origin body of let* expression

;; It is sufficient to add a clause to eval for this to work:
;; (eval (let*->nested-lets exp) env)
;; So, answering the book's question: let* can be implemented as derived exp

(define (make-let bindings body)
  (cons 'let (cons bindings body)))

(define (let*? exp) (tagged-list? exp 'let*))

(define (let*->nested-lets exp)
  (print (expand-lets (let-bindings exp) (let-body exp)))
  (expand-lets (let-bindings exp) (let-body exp)))

(define (expand-lets bindings body)
  (if (null? bindings)
    (make-let '() body)
    (let ((first-binding (car bindings))
          (rest (cdr bindings)))
      (if (null? rest)
        (make-let (list first-binding) body)
        (make-let (list first-binding)
                  (list (expand-lets (cdr bindings) body)))))))

;; new cond clause for eval
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ;; ...
        ((let*? exp) (eval (let*->nested-lets exp) env))
        ;; ...
        ))

