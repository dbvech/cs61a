;; --- 1 ---
;; It works cause as side effects there are two procedures - newline and display,
;; display is a primitive, thus it forcing it's argument to actual value.

;; --- 2 ---
(define (p1 x)
  (set! x (cons x '(2))) x)

(define (p2 x)
  (define (p e) e x)
  (p (set! x (cons x '(2)))))

(p1 1)
;; => (1 2)
;; works as expected

(p2 1)
;; => 1
;; because we didn't pass var "e" (inside p) to any primitive procedure,
;; it never evaluated

;; With Cy's proposed changes values would be:
(p1 1)
;; => (1 2)

(p2 1)
;; => (1 2)

;; --- 3 ---
;; Without the Cy's change expressions (newline) and (display x) were 
;; evaluated cause both of them were passed to eval. (newline) is a procedure
;; call, and eval always invoke actual-value for left-most operand (procedure 
;; name). As for (display x) - display is passed to actual-value too, for same
;; resons, x is passed to actual-value cause "display" is a primitive procedure.
;; Both of those expressions will be evaluated the same with Cy's change

;; --- 4 ---
;; I think with Cy's change the program behaves more predictably.

