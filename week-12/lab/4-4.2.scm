;; 1. What is wrong with Louis’s plan? (Hint: What will Louis’s evaluator do with 
;; the expression (define x 3)?) 

;; application? predicate just checks whether the exp is a pair. Thus,
;; ANY special cases (define, if, cond, etc...) would be IGNORED cause all of
;; them are also pairs. Firstly need to check ALL special cases.

(define x 3)
;; => Unbound variable (cause define is not a procedure, it's "special" case)

;; 2. Louis is upset that his plan didn’t work. He is willing to go to any 
;; lengths to make his evaluator recognize procedure applications before it 
;; checks for most other kinds of expressions. Help him by changing the syntax 
;; of the evaluated language so that procedure applications start with call. 
;; For example, instead of (factorial 3) we will now have to write 
;; (call factorial 3) and instead of (+ 1 2) we will have to write (call + 1 2).

(define (application? exp) (tagged-list? exp 'call))
(define (operator exp) (cadr exp))
(define (operands exp) (cddr exp))
