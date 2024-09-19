;; first wee need to change frame data abstraction:
(define (make-frame variables values)
  (CONS '*FRAME* (MAP CONS VARIABLES VALUES)))

(define (add-binding-to-frame! var val frame)
  (set-cdr! frame (cons (cons var val) (cdr frame))))

;; replace "frame-variables" and "frame-values" selectors with one:
(define (frame-bindings frame) (cdr frame))

;; next we need to change "env" data abstractions cause
;; it's knows about internals of frame abstraction
(define (lookup-variable-value var env)
  (define (env-loop env)
    (DEFINE (SCAN BINDINGS)
            (LET ((BINDING (ASSOC VAR BINDINGS)))
                 (IF BINDING
                     (CDR BINDING)
                     (ENV-LOOP (ENCLOSING-ENVIRONMENT ENV)))))
    (if (eq? env the-empty-environment)
      (error "Unbound variable" var)
      (let ((frame (first-frame env)))
        (SCAN (FRAME-BINDINGS FRAME)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (DEFINE (SCAN BINDINGS)
            (LET ((BINDING (ASSOC VAR BINDINGS)))
                 (IF BINDING
                     (SET-CDR! BINDING VAL)
                     (ENV-LOOP (ENCLOSING-ENVIRONMENT ENV)))))
    (if (eq? env the-empty-environment)
      (error "Unbound variable -- SET!" var)
      (let ((frame (first-frame env)))
        (SCAN (FRAME-BINDINGS FRAME)))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (DEFINE (SCAN BINDINGS)
            (LET ((BINDING (ASSOC VAR BINDINGS)))
                 (IF BINDING
                     (SET-CDR! BINDING VAL)
                     (ADD-BINDING-TO-FRAME! VAR VAL FRAME))))
    (SCAN (FRAME-BINDINGS FRAME))))
