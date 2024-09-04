(load "obj")
(load "adv")
(load "tables")
(load "adv-world")

;; changes (adv.scm)
;; - add a new method in the person class
;;
;;  (method (go direction)
;;    (let ((new-place (ask place 'look-in direction)))
;;      (cond ((null? new-place)
;;	     (error "Can't go" direction))
;;	    ((not (ask new-place 'may-enter? self)) 
;;	     (error "The place is locked:" (ask new-place 'name)))
;;	    (ELSE (ASK SELF 'GO-DIRECTLY-TO NEW-PLACE))))) <- use new method
;;  (method (go-directly-to new-place)   <- new method
;;    (ask place 'exit self)
;;    (announce-move name place new-place)
;;    (for-each
;;     (lambda (p)
;;       (ask place 'gone p)
;;       (ask new-place 'appear p))
;;     possessions)
;;    (set! place new-place)
;;    (ask new-place 'enter self)))
;;
;; - add a new class police
;;
;;   (define-class (police name place)
;;     (parent (person name place))
;;     (method (catch the-thief jail)
;;             (if (not (thief? the-thief))
;;               (error ("Not a thief!"))
;;               (ask the-thief 'go-directly-to jail))))
;;
;; - change notice method in the thief class (changes in uppercase)
;;
;;  (method (notice person)
;;    (if (eq? behavior 'run)
;;	(LET ((EXITS (ASK (USUAL 'PLACE) 'EXITS))) 
;;	  (IF (NOT (NULL? EXITS))
;;	    (ASK SELF 'GO (PICK-RANDOM EXITS))))
;;	(let ((food-things
;;	       (filter (lambda (thing)
;;			 (and (edible? thing)
;;
;; - new utility:
;; 
;;   (define (thief? obj)
;;     (and (person? obj)
;;          (eq? (ask obj 'type) 'thief)))
;;
;; changes (adv-world.scm)
;; - add a new place jail
;;
;;   (define jail (instantiate place 'jail))


;; TESTS
(define victim (instantiate person 'John Telegraph-Ave))
(define the-thief (instantiate thief 'Rob Noahs))
(define the-police (instantiate police 'Police Pimentel))

(define pizza (instantiate thing 'pizza))
(define coffee (instantiate thing 'coffee))

(ask Telegraph-Ave 'appear pizza)
(ask Telegraph-Ave 'appear coffee)

(ask victim 'take pizza)
(ask victim 'take coffee)

(ask victim 'go 'south)
;; => john moved from telegrapth-ave
;; => rob took pizza
;; => rob moved from noah to telegrapth-ave

(ask the-police 'catch the-thief jail)
;; => rob moved from telegraph-ave to jail
