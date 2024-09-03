(load "obj")
(load "adv")
(load "tables")
(load "adv-world")

(define-class (ticket number)
  (parent (thing 'ticket)))

(define-class (garage name)
  (parent (place name))

  (class-vars (ticket-number 0))
  (instance-vars (records (make-table)))

  (method (next-ticket-number)
          (set! ticket-number (+ ticket-number 1))
          ticket-number)

  (method (park the-car)
          (let ((possessor (ask the-car 'possessor)))
            (cond
              ((symbol? possessor) (error "The car doesn't belong to anybody"))
              ((not (eq? self (ask possessor 'place))) (error "The car is not in the garage"))
              (else
               (let ((the-ticket (instantiate ticket (ask self 'next-ticket-number))))
                 (insert! (ask the-ticket 'number) the-car records)
                 (ask self 'appear the-ticket)
                 (ask possessor 'lose the-car)
                 (ask possessor 'take the-ticket)
                 (display (ask the-car 'name))
                 (display " is parked! Ticket number is ")
                 (display (ask the-ticket 'number))
                 (newline))))))

  (method (unpark the-ticket)
          (if (not (eq? (ask the-ticket 'name) 'ticket))
            (error "The thing is not a ticket")
            (let ((the-car (lookup (ask the-ticket 'number) records))
                  (owner (ask the-ticket 'possessor)))
              (if (not the-car) (error "Car not found: invalid ticket"))
              (ask owner 'lose the-ticket)
              (ask owner 'take the-car)
              (insert! (ask the-ticket 'number) #f records)
              (display (ask the-car 'name))
              (display " is unparked!")
              (newline)))))


;; TESTS
(define test-garage (instantiate garage 'Test-Garage))
(can-go Intermezzo 'south test-garage)

(define test-man (instantiate person 'Test-Man Intermezzo))

(define bmw (instantiate thing 'bmw))
(define coca-cola (instantiate thing 'Coca-cola))

(ask Intermezzo 'appear bmw)
(ask Intermezzo 'appear coca-cola)

;; (ask test-garage 'park bmw)
;; => error: The car doesn't belong to anybody

(ask test-man 'take bmw)
;; => test-man took bmw

(ask test-man 'take coca-cola)
;; => test-man took coca-cola

;; (ask test-garage 'park bmw)
;; => error: The car is not in the garage

(ask test-man 'go 'south)
;; => test-man moved from intermezzo to test-garage

(ask test-garage 'park bmw)
;; => bmw is parked! ticket number is 

;; (ask test-garage 'unpark coca-cola)
;; => error: The thing is not a ticket

(define bmw-ticket (car (filter
                         (lambda (thing) (eq? (ask thing 'name) 'ticket))
                         (ask test-man 'possessions))))

(ask test-garage 'unpark bmw-ticket)
;; => test-man took bmw
;; => bmw is unparked!

;; (ask test-garage 'unpark bmw-ticket)
;; => error: Car not found: invalid ticket
