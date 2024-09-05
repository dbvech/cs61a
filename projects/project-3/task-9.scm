(load "obj")
(load "adv")
(load "tables")
(load "adv-world")

;; Changes in adv.scm
;; - change restaurant class to serve police for free (changes in uppercase)
;;
;;   (method (sell buyer food-name)
;;           (cond
;;             ((not (equal? food-name (ask food-class 'name)))
;;              (print "Sorry, we don't have such food")
;;              #f)
;;             ((NOT (OR (POLICE? BUYER) 
;;                       (ASK BUYER 'PAY-MONEY FOOD-PRICE)))
;;              (print "Sorry, you don't have enough money")
;;              #f)
;;             (else (let ((the-food (instantiate food-class)))
;;                     (ask self 'appear the-food)
;;                     the-food)))))
;;
;; - add util police?
;;
;;   (define (police? obj)
;;     (and (person? obj)
;;          (eq? (ask obj 'type) 'police)))

;; TESTS:

(define-class (burger)
  (parent (food 344))
  (class-vars
   (name 'burger)))

(define mcdonalds (instantiate restaurant 'McDonalds burger 9.99))

(define policeman (instantiate police 'Bob mcdonalds))
(ask policeman 'money)
;; => 100
(ask policeman 'buy 'burger)
;; => bob took burger
(ask policeman 'possessions)
;; => (#[closure...])
(ask policeman 'money)
;; => 100

(define regular-person (instantiate person 'Mike mcdonalds))
(ask regular-person 'money)
;; => 100
(ask regular-person 'buy 'burger)
;; => mike took burger
(ask regular-person 'possessions)
;; => (#[closure...])
(ask regular-person 'money)
;; => 90.01
