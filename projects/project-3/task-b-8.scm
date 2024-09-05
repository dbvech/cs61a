(load "obj")
(load "adv")
(load "tables")
(load "adv-world")

;; Changes in adv.scm:
;; - add new method may-take? in thing class
;;   (define-class (thing name)
;;     ...
;;     (method (may-take? receiver)
;;            (if (eq? possessor 'no-one)
;;              self
;;              (and (> (ask receiver 'strength)
;;                      (ask possessor 'strength))
;;                   self)))
;;     ...
;;     )
;;
;; - change take method in person class
;;
;;   (method (take thing)
;;     (cond ((not (thing? thing)) (error "Not a thing" thing))
;; 	  ((not (memq thing (ask place 'things)))
;; 	   (error "Thing taken not at this place"
;; 		  (list (ask place 'name) thing)))
;; 	  ((memq thing possessions) (error "You already have it!"))
;;        ((eq? 'no-one (ask thing 'possessor))
;; 	   (announce-take name thing)
;; 	   (set! possessions (cons thing possessions))
;;         (ask thing 'change-possessor self)
;; 	   'taken)
;;   	  (else 
;;         (let ((thing (ask thing 'may-take? self)))
;;           (if (not thing)
;;             (error (string-append (symbol->string name) 
;;                                   " cannot take the thing")))
;;           (announce-take name thing)
;;           (set! possessions (cons thing possessions))
;;  	  
;;           ;; If somebody already has this object...
;;           (for-each
;;            (lambda (pers)
;;              (if (and (not (eq? pers self)) ; ignore myself
;;                       (memq thing (ask pers 'possessions)))
;;                  (begin
;;                   (ask pers 'lose thing)
;;                   (have-fit pers))))
;;            (ask place 'people))
;;               
;;           (ask thing 'change-possessor self)
;;           'taken))))


;; TESTS:
(define john (instantiate person 'John Soda))
(define jack (instantiate person 'Jack Soda))

(define macbook (instantiate laptop 'mbp15))
(ask Soda 'appear macbook)

(ask john 'take macbook)
;; => john took mbp15

;; (ask jack 'take macbook)
;; => jack cannot take the thing

(ask jack 'strength)
;; => 50

(define the-sushi (instantiate sushi))
(ask Soda 'appear the-sushi)

(ask jack 'take the-sushi)
;; => jack took sushi
(ask jack 'eat)
;; => sushi: eaten by jack
(ask jack 'strength)
;; => 255

(ask jack 'take macbook)
;; => jack took mbp15
;; => Yaaah! john is upset!
;; => taken
