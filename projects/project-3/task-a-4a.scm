(load "obj")
(load "adv")
(load "tables")
(load "adv-world")

(define singer (instantiate person 'rick sproul-plaza))

(ask singer 'set-talk "My funny valentine, sweet comic valentine")

(define preacher (instantiate person 'preacher sproul-plaza))

(ask preacher 'set-talk "Praise the Lord")

(define street-person (instantiate person 'harry telegraph-ave))

(ask street-person 'set-talk "Brother, can you spare a buck")


;; TRANSCRIPT

(ask street-person 'go 'north)
;; => harry moved from telegraph-ave to sproul-plaza
;; => Praise the Lord
;; => My funny valentine, sweet comic valentine

(ask singer 'go 'south)
;; => rick moved from sproul-plaza to telegraph-ave
;; => There are tie-dyed shirts as far as you can see...

(ask singer 'go 'north)
;; => rick moved from telegraph-ave to sproul-plaza
;; => Brother, can you spare a buck
;; => Praise the Lord

(ask preacher 'go 'south)
;; => preacher moved from sproul-plaza to telegraph-ave
;; => There are tie-dyed shirts as far as you can see...

(ask preacher 'go 'north)
;; => preacher moved from telegraph-ave to sproul-plaza
;; => My funny valentine, sweet comic valentine
;; => Brother, can you spare a buck
