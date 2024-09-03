(load "obj")
(load "adv")
(load "tables")
(load "adv-world")

;; Changes (adv.scm):

;; (define (laptop? thing)
;;   (and (procedure? thing)
;;        (eq? (ask thing 'type) 'laptop)))
;;
;; (define-class (hotspot name password)
;;   (parent (place name))
;;   (instance-vars
;;    (connected-devices (list)))
;;   (method (type) 'hotspot)
;;   (method (connect the-laptop the-password)
;;           (cond
;;             ((not (laptop? the-laptop)) (error "The thing is not a laptop"))
;;             ((not (eq? password the-password)) (error "Incorrect password"))
;;             ((not (memq the-laptop (ask self 'things))) (error "The thing is not in hotspot place"))
;;             ((memq the-laptop connected-devices) "Already connected")
;;             (else (set! connected-devices
;;                         (cons the-laptop connected-devices))
;;                   (display "laptop connected: ")
;;                   (display (ask the-laptop 'name))
;;                   (newline))))
;;   (method (surf the-laptop url)
;;           (if (memq the-laptop connected-devices)
;;             (system (string-append "curl " url))))
;;   (method (gone thing)
;;           (usual 'gone thing)
;;           (if (and (laptop? thing)
;;                    (memq thing connected-devices))
;;             (begin
;;              (set! connected-devices (delete thing connected-devices))
;;              (display "laptop disconnected: ")
;;              (display (ask thing 'name))
;;              (newline)))))
;;
;; (define-class (laptop name)
;;   (parent (thing name))
;;   (method (type) 'laptop)
;;   (method (connect password)
;;           (let ((possessor (ask self 'possessor)))
;;             (if (not (person? possessor))
;;               (error "The laptop should be picked up by someone before connect"))
;;             (ask (ask possessor 'place) 'connect self password)))
;;   (method (surf url)
;;           (let ((possessor (ask self 'possessor)))
;;             (if (not (person? possessor))
;;               (error "The laptop should be picked up by someone before surf"))
;;             (ask (ask possessor 'place) 'surf self url))))
;;

;; TESTS
(define internet-cafe (instantiate hotspot 'Internet-Cafe 'secret))
(can-go Pimentel 'east internet-cafe)
(can-go internet-cafe 'west Pimentel)

(define mbp15 (instantiate laptop 'MBP-15))
(define mbp16 (instantiate laptop 'MBP-16))

(ask Pimentel 'appear mbp15)
(ask Pimentel 'appear mbp16)

(define test-man1 (instantiate person 'Tester1 Pimentel))
(define test-man2 (instantiate person 'Tester2 Pimentel))

(ask test-man1 'take mbp15)
;; => tester1 took mbp-15
(ask test-man2 'take mbp16)
;; => tester2 took mbp-16

;; (ask mbp15 'connect '123)
;; => #f

(ask test-man1 'go 'east)
(ask test-man2 'go 'east)

;; (ask mbp15 'connect '123)
;; => error: incorrect password

(ask internet-cafe 'connected-devices)
;; => ()

(ask mbp15 'connect 'secret)
;; => laptop connected: mbp-15

(ask internet-cafe 'connected-devices)
;; => (#[closure mbp15])

(ask mbp16 'connect 'secret)
;; => laptop connected: mbp-16

(ask internet-cafe 'connected-devices)
;; => (#[closure mbp16] #[closure mbp15])

(ask mbp15 'surf "www.google.com")
;; => *html page from curl*

(ask test-man1 'go 'west)
;; => tester1 moved from internet-cafe to pimentel
;; => laptop disconnected: mbp-15

(ask internet-cafe 'connected-devices)
;; => (#[closure mbp16])

(ask test-man2 'go 'west)
;; => tester2 moved from internet-cafe to pimentel
;; => laptop disconnected: mbp-16

(ask internet-cafe 'connected-devices)
;; => ()
