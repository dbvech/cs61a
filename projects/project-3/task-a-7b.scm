(load "obj")
(load "adv")
(load "tables")
(load "adv-world")

;; Changes in (adv.scm)
;; - add new class restaurant
;;   (define-class (restaurant name food-class food-price)
;;     (parent (place name))
;;
;;     (method (menu)
;;             (list (cons (ask food-class 'name) food-price)))
;;     (method (sell buyer food-name)
;;             (cond
;;               ((not (equal? food-name (ask food-class 'name)))
;;                (print "Sorry, we don't have such food")
;;                #f)
;;               ((not (ask buyer 'pay-money food-price))
;;                (print "Sorry, you don't have enough money")
;;                #f)
;;               (else (let ((the-food (instantiate food-class)))
;;                (ask self 'appear the-food)
;;                the-food)))))


;; TESTS
(define sushi-bar (instantiate restaurant 'Sushi-bar sushi 29))

(ask sushi-bar 'menu)
;; => ((sushi . 29))

(define buyer (instantiate person 'Buyer sushi-bar))

(ask sushi-bar 'sell buyer 'burger)
;; => Sorry, we don't have such food

(ask buyer 'money)
;; => 100

(ask sushi-bar 'sell buyer 'sushi)
;; => closure

(ask buyer 'money)
;; => 71

(ask sushi-bar 'sell buyer 'sushi)
;; => closure
(ask sushi-bar 'sell buyer 'sushi)
;; => closure
(ask sushi-bar 'sell buyer 'sushi)
;; => Sorry, you don't have enough money
;; => #f
