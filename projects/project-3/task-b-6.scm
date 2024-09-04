(load "obj")
(load "adv")
(load "tables")
(load "adv-world")

;; Changes in adv.scm:
;; - add a new class food
;;   (define-class (food name calories)
;;     (parent (thing name))
;;     (initialize
;;      (ask self 'put 'edible? #t)))

;; - change edible? procedure to:
;;   (define (edible? thing)
;;     (ask thing 'edible?))

;; - add some food
;;   (define-class (bagel)
;;     (parent (food 250))
;;     (class-vars
;;      (name 'bagel)))
;;
;;   (define-class (sushi)
;;     (parent (food 205))
;;     (class-vars
;;      (name 'sushi)))
;;
;;   (define-class (coffee)
;;     (parent (food 100))
;;     (class-vars
;;      (name 'coffee)))

;; - add method eat for person:
;;   (method (eat)
;;     (map (lambda (food)
;;            (set! possessions (delete food possessions))
;;            (ask place 'gone food)
;;            (ask self 'put 'strength (+ (ask self 'strength) 
;;                                        (ask food 'calories)))
;;            (display (ask food 'name))
;;            (display ": eaten!\n"))
;;          (filter edible? possessions)))

;; Changes in adv-world.scm:
;; - REPLACE following lines
;; 
;;   (define bagel (instantiate thing 'bagel))
;;   (ask Noahs 'appear bagel)
;;  
;;   (define coffee (instantiate thing 'coffee))
;;   (ask Intermezzo 'appear coffee)
;;   
;;   WITH:
;; 
;;   (define the-bagel (instantiate bagel))
;;   (ask Noahs 'appear the-bagel)
;;  
;;   (define the-coffee (instantiate coffee))
;;   (ask Intermezzo 'appear the-coffee)

;; TESTS:
(define tester (instantiate person 'Tester Soda))
(define the-bagel (instantiate bagel))
(define the-sushi (instantiate sushi))

(ask Soda 'appear the-bagel)
(ask Soda 'appear the-sushi)

(ask tester 'take the-bagel)
;; => tester took bagel

(ask tester 'strength)
;; => 50

(ask tester 'eat)
;; => bagel: eaten by tester

(ask tester 'strength)
;; => 300

(ask tester 'take the-sushi)
;; => tester took sushi

(ask tester 'eat)
;; => sushi: eaten by tester

(ask tester 'strength)
;; => 505
