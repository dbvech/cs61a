(load "obj")
(load "adv")
(load "tables")
(load "adv-world")

;; Add this method in Person class
;; ...
;; (method (take-all)
;;         (for-each
;;          (lambda (thing)
;;                  (if (eq? (ask thing 'possessor) 'no-one) (ask self 'take thing)))
;;          (ask place 'things)))
;; ...

;; TESTS
(define test-person-1 (instantiate person 'Person-1 Soda))
(define test-person-2 (instantiate person 'Person-2 Soda))

(define coca-cola (instantiate thing 'coca-cola))
(define fanta (instantiate thing 'fanta))
(define sprite (instantiate thing 'sprite))

(ask Soda 'appear coca-cola)
(ask Soda 'appear fanta)
(ask Soda 'appear sprite)

(ask test-person-1 'take-all)
;; => person-1 took sprite
;; => person-1 took fanta
;; => person-1 took coca-cola

(ask test-person-1 'lose coca-cola)
;; => lost
(ask test-person-1 'lose fanta)
;; => lost

(ask test-person-2 'take-all)
;; => person-1 took fanta
;; => person-1 took coca-cola
