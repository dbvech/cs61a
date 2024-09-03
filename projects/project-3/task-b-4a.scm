(load "obj")
(load "adv")
(load "tables")
(load "adv-world")

;; Changes:
;; - add new class
;;   (define-class (basic-object)
;;     (instance-vars (properties (make-table)))
;;     (method (put attr val)
;;       (insert! attr val properties))
;;     (default-method (lookup message properties)))
;; 
;; - person, place, thing classes inherit basic-object class 
;;   (define-class (person name place)
;;     (parent (basic-object))
;;
;;   (define-class (place name)
;;     (parent (basic-object))
;;
;;   (define-class (thing name)
;;     (parent (basic-object))
;;
;; - add initial strength in PERSON class
;;   ...
;;   (initialize
;;    (ask place 'enter self)
;;    (ask self 'put 'strength 50))    <- ADD THIS LINE
;;   ...

;; TESTS
(ask Brian 'strength)
;; => 50

(ask Brian 'put 'strength 100)
;; => ok

(ask Brian 'strength)
;; => 100

(ask Brian 'charisma)
=> #f
