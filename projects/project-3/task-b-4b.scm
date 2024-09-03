;; Changes (adv.scm):
;; - add new method to place class
;;   (method (place?) #t)
;;
;; - add new method to person class
;;   (method (person?) #t)
;;
;; - add new method to thing class
;;   (method (thing?) #t)
;;
;; - change type predicates: 
;;   (define (place? obj)
;;     (and (procedure? obj)
;;          (ask obj 'place?)))
;;
;;   (define (person? obj)
;;     (and (procedure? obj)
;;          (ask obj 'person?)))
;;
;;   (define (thing? obj)
;;     (and (procedure? obj)
;;          (ask obj 'thing?)))
