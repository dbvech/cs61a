(load "obj")
(load "adv")
(load "tables")
(load "adv-world")

;; Changes in adv.scm:
;; - add new class police
;;   (define-class (police name initial-place)
;;     (parent (person name initial-place))
;;     (initialize (ask self 'put 'strength 300))
;;  
;;     (method (type) 'police)
;;  
;;     (method (notice person)
;;             (if (thief? person)
;;               (begin
;;                (print "Crime Does Not Pay,")
;;                (for-each (lambda (the-thing) (ask self 'take the-thing))
;;                          (ask person 'possessions))
;;                (ask person 'go-directly-to jail)))))


;; TESTS:
(define victim (instantiate person 'John Telegraph-Ave))
(define the-police (instantiate police 'Police Soda))

(define yammi-bagel (instantiate bagel))

(ask Telegraph-Ave 'appear yammi-bagel)

(ask victim 'take yammi-bagel)
;; => john took bagel

(ask victim 'go 'north)
;; => john moved from telegrapth-ave to sproul-plaza
;; => nasty took bagel
;; => Yaaah! john is upset!
;; => nasty moved from sproul-plaza to pimentel

(ask victim 'go 'north)
;; => john moved from sproul-plaza to pimentel
;; => nasty moved from pimentel to soda
;; => Crime Does Not Pay,
;; => police took bagel
;; => Yaaah! nasty is upset!
;; => nasty moved from soda to jail

;; BUSTED
