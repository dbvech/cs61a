;; unless as a derived expression (special form)
;; new cond clause in eval procedure
((unless? exp) (mc-eval (unless->if exp) env))

;; unless data abstraction
(define (unless? exp) (tagged-list? exp 'unless))

(define unless-condition cadr)
(define unless-usual caddr)
(define unless-exceptional cadddr)

(define (unless->if exp)
  (make-if (unless-condition exp)
           (unless-exceptional exp)
           (unless-usual exp)))

;; However, the special form of "unless" would not work in situations
;; where we might want to pass it as the arg to another procedure,
;; cause it is not a procedure, thus can't be passed by reference


