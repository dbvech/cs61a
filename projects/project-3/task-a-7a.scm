(load "obj")
(load "adv")
(load "tables")
(load "adv-world")

;; Changes in (adv.scm)
;; - add money on initialization
;;   (initialize
;;     (ask place 'enter self)
;;     (ask self 'put 'strength 50)
;;     (ask self 'put 'money 100)) <- this line added
;; - add pay-money and get-money methods
;;   (method (get-money amount)
;;           (ask self 'put 'money (+ (ask self 'money) amount)))
;;   (method (pay-money amount)
;;           (let ((balance (ask self 'money)))
;;             (if (> amount balance) 
;;               #f
;;               (begin 
;;                 (ask self 'put 'money (- balance amount))
;;                 #t))))


(define me (instantiate person 'Me Soda))

(ask me 'money)
;; => 100

(ask me 'pay-money 60)
;; => #t

(ask me 'money)
;; => 40

(ask me 'pay-money 60)
;; => #f

(ask me 'get-money 20)
;; => ok

(ask me 'pay-money 60)
;; => #t

(ask me 'money)
;; => 0
