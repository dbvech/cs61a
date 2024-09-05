(load "obj")
(load "adv")
(load "tables")
(load "adv-world")

;; Changes in (adv.scm)
;; - add buy method to person class
;;   (method (buy food-name)
;;           (if (not (restaurant? place))
;;             (error "The current place is not a restaurant")
;;             (let ((the-food (aks place 'sell self food-name)))
;;               (if (not the-food)
;;                 (begin 
;;                   (display name)
;;                   (display ": cannot buy a ")
;;                   (display food-name))
;;                 (ask self 'take the-food)))))


;; TESTS
(define sushi-bar (instantiate restaurant 'Sushi-bar sushi 29))
(can-go Intermezzo 'west sushi-bar)

(define buyer (instantiate person 'Buyer Intermezzo))

;; (ask buyer 'buy 'sushi)
;; => error: The current place is not a restaurant

(ask buyer 'go 'west)
;; => buyer moved from intermezzo to sushi-bar

(ask buyer 'possessions)
;; => ()
(ask buyer 'money)
;; => 100

(ask buyer 'buy 'sushi)
;; => buyer took sushi
;; => taken

(ask buyer 'possessions)
;; => (#[closure...])
(ask buyer 'money)
;; => 71

(ask buyer 'buy 'sushi)
;; => buyer took sushi
;; => taken

(ask buyer 'possessions)
;; => (#[closure...] #[closure...])
(ask buyer 'money)
;; => 42

(ask buyer 'strength)
;; => 50

(ask buyer 'eat)
;; => sushi: eaten by buyer
;; => sushi: eaten by buyer

(ask buyer 'strength)
;; => 460
