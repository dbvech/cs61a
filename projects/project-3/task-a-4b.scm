(load "obj")
(load "adv")
(load "tables")
(load "adv-world")

;; List of changes:

;; Place class:
;; new method:
;; (method (may-enter? person) #t)

;; [NEW] Locked-place class
;; (define-class (locked-place name)
;;   (parent (place name))
;;   (instance-vars
;;    (locked #t))
;;   (method (may-enter? person) (not locked))
;;   (method (unlock)
;;           (set! locked #f)
;;           (display name)
;;           (display " is unlocked!\n")))

;; Person class:
;; (method (go direction)
;;   (let ((new-place (ask place 'look-in direction)))
;;     (cond ((null? new-place)
;;     (error "Can't go" direction))
;;    ((not (ask new-place 'may-enter? self))   <- Here is the change
;;     (error "The place is locked:" (ask new-place 'name)))
;;    (else
;;     (ask place 'exit self)
;;     (announce-move name place new-place)
;;     (for-each
;;      (lambda (p)
;;        (ask place 'gone p)
;;        (ask new-place 'appear p))
;;      possessions)
;;     (set! place new-place)
;;     (ask new-place 'enter self))))) )


(define fallout-81 (instantiate locked-place 'Fallout-81))
(can-go Sproul-Plaza 'west fallout-81)
(define tester (instantiate person 'Tester Sproul-Plaza))

(ask tester 'go 'west)
;; => error: The place is locked: fallout-81

(ask fallout-81 'unlock)
;; => fallout-81 is unlocked!

(ask tester 'go 'west)
;; => tester moved from sproul-plaza to fallout-81
