;; add new cond in analyze procedure
((if-fail? exp) (analyze-if-fail exp))

;; if-fail data-abstraction
(define (if-fail? exp) (tagged-list? exp 'if-fail))
(define (if-fail-usual exp) (cadr exp))
(define (if-fail-alternative exp) (caddr exp))

;; analyze procedure for if-fail special form
(define (analyze-if-fail exp)
  (let ((uproc (analyze (if-fail-usual exp)))
        (fproc (analyze (if-fail-alternative exp))))
    (lambda (env succeed fail)
            (uproc env
                   succeed
                   (lambda () (fproc env succeed fail))))))

;; test (should be entered in amb-eval)

;;; Amb-Eval input:
(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items)
       (an-element-of (cdr items))))

;;; Starting a new problem
;;; Amb-Eval value:
ok

;;; Amb-Eval input:
(if-fail
 (let ((x (an-element-of '(1 3 5))))
   (require (even? x))
   x)
 'all-odd)

;;; Starting a new problem
;;; Amb-Eval value:
all-odd

;;; Amb-Eval input:
(if-fail
 (let ((x (an-element-of '(1 3 5 8))))
   (require (even? x))
   x)
 'all-odd)

;;; Starting a new problem
;;; Amb-Eval value:
8

;;; Amb-Eval input:
try-again

;;; Amb-Eval value:
all-odd

;;; Amb-Eval input:
try-again

;;; There are no more values of
(if-fail (let ((x (an-element-of '(1 3 5 8)))) (require (even? x)) x) 'all-odd)
