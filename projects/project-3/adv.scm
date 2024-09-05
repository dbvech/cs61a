;; ADV.SCM
;; This file contains the definitions for the objects in the adventure
;; game and some utility procedures.

(define-class (basic-object)
  (instance-vars (properties (make-table)))
  (method (put attr val)
    (insert! attr val properties))
  (default-method (lookup message properties)))

(define-class (place name)
  (parent (basic-object))

  (instance-vars
   (directions-and-neighbors '())
   (things '())
   (people '())
   (entry-procs '())
   (exit-procs '()))
  (method (type) 'place)
  (method (place?) #t)
  (method (neighbors) (map cdr directions-and-neighbors))
  (method (exits) (map car directions-and-neighbors))
  (method (look-in direction)
    (let ((pair (assoc direction directions-and-neighbors)))
      (if (not pair)
	  '()                     ;; nothing in that direction
	  (cdr pair))))           ;; return the place object
  (method (appear new-thing)
    (if (memq new-thing things)
	(error "Thing already in this place" (list name new-thing)))
    (set! things (cons new-thing things))
    'appeared)
  (method (may-enter? person) #t)
  (method (enter new-person)
    (if (memq new-person people)
	(error "Person already in this place" (list name new-person)))
    (set! people (cons new-person people))
    (for-each (lambda (proc) (proc)) entry-procs)
    (for-each (lambda (person) (ask person 'notice new-person)) (cdr people))
    'appeared)
  (method (gone thing)
    (if (not (memq thing things))
	(error "Disappearing thing not here" (list name thing)))
    (set! things (delete thing things)) 
    'disappeared)
  (method (exit person)
    (for-each (lambda (proc) (proc)) exit-procs)
    (if (not (memq person people))
	(error "Disappearing person not here" (list name person)))
    (set! people (delete person people)) 
    'disappeared)

  (method (new-neighbor direction neighbor)
    (if (assoc direction directions-and-neighbors)
	(error "Direction already assigned a neighbor" (list name direction)))
    (set! directions-and-neighbors
	  (cons (cons direction neighbor) directions-and-neighbors))
    'connected)

  (method (add-entry-procedure proc)
    (set! entry-procs (cons proc entry-procs)))
  (method (add-exit-procedure proc)
    (set! exit-procs (cons proc exit-procs)))
  (method (remove-entry-procedure proc)
    (set! entry-procs (delete proc entry-procs)))
  (method (remove-exit-procedure proc)
    (set! exit-procs (delete proc exit-procs)))
  (method (clear-all-procs)
    (set! exit-procs '())
    (set! entry-procs '())
    'cleared) )

(define-class (locked-place name)
  (parent (place name))
  (instance-vars 
    (locked #t))
  (method (may-enter? person) (not locked))
  (method (unlock) 
    (set! locked #f)
    (display name)
    (display " is unlocked!\n")))

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

(define-class (hotspot name password)
  (parent (place name))
  (instance-vars
   (connected-devices (list)))
  (method (type) 'hotspot)
  (method (connect the-laptop the-password)
          (cond
            ((not (laptop? the-laptop)) (error "The thing is not a laptop"))
            ((not (eq? password the-password)) (error "Incorrect password"))
            ((not (memq the-laptop (ask self 'things))) (error "The thing is not in hotspot place"))
            ((memq the-laptop connected-devices) "Already connected")
            (else (set! connected-devices
                        (cons the-laptop connected-devices))
                  (display "laptop connected: ")
                  (display (ask the-laptop 'name))
                  (newline))))
  (method (surf the-laptop url)
          (if (memq the-laptop connected-devices)
            (system (string-append "curl " url))))
  (method (gone thing)
          (usual 'gone thing)
          (if (and (laptop? thing)
                   (memq thing connected-devices))
            (begin
             (set! connected-devices (delete thing connected-devices))
             (display "laptop disconnected: ")
             (display (ask thing 'name))
             (newline)))))

(define-class (restaurant name food-class food-price)
  (parent (place name))

  (method (type) 'restaurant)
  (method (menu)
          (list (cons (ask food-class 'name) food-price)))
  (method (sell buyer food-name)
          (cond
            ((not (equal? food-name (ask food-class 'name)))
             (print "Sorry, we don't have such food")
             #f)
            ((not (or (police? buyer) 
                      (ask buyer 'pay-money food-price)))
             (print "Sorry, you don't have enough money")
             #f)
            (else (let ((the-food (instantiate food-class)))
                    (ask self 'appear the-food)
                    the-food)))))

(define-class (person name place)
  (parent (basic-object))

  (instance-vars
   (possessions '())
   (saying ""))
  (initialize
   (ask place 'enter self)
   (ask self 'put 'strength 50)
   (ask self 'put 'money 100))
  (method (type) 'person)
  (method (person?) #t)
  (method (get-money amount)
          (ask self 'put 'money (+ (ask self 'money) amount)))
  (method (pay-money amount)
          (let ((balance (ask self 'money)))
            (if (> amount balance) 
              #f
              (begin 
                (ask self 'put 'money (- balance amount))
                #t))))
  (method (eat)
    (for-each (lambda (food)
           (set! possessions (delete food possessions))
           (ask place 'gone food)
           (ask self 'put 'strength (+ (ask self 'strength) 
                                       (ask food 'calories)))
           (display (ask food 'name))
           (display ": eaten by ")
           (display (ask self 'name))
           (newline))
         (filter edible? possessions)))
  (method (buy food-name)
          (if (not (restaurant? place))
            (error "The current place is not a restaurant")
            (let ((the-food (ask place 'sell self food-name)))
              (if (not the-food)
                (begin 
                  (display name)
                  (display ": cannot buy a ")
                  (display food-name))
                (ask self 'take the-food)))))
  (method (look-around)
    (map (lambda (obj) (ask obj 'name))
	 (filter (lambda (thing) (not (eq? thing self)))
		 (append (ask place 'things) (ask place 'people)))))
  (method (take thing)
    (cond ((not (thing? thing)) (error "Not a thing" thing))
	  ((not (memq thing (ask place 'things)))
	   (error "Thing taken not at this place"
		  (list (ask place 'name) thing)))
	  ((memq thing possessions) (error "You already have it!"))
          ((eq? 'no-one (ask thing 'possessor))
	   (announce-take name thing)
	   (set! possessions (cons thing possessions))
           (ask thing 'change-possessor self)
	   'taken)
  	  (else 
           (let ((thing (ask thing 'may-take? self)))
             (if (not thing)
               (error (string-append (symbol->string name) 
                                     " cannot take the thing")))
             (announce-take name thing)
             (set! possessions (cons thing possessions))
 	     
             ;; If somebody already has this object...
             (for-each
              (lambda (pers)
                (if (and (not (eq? pers self)) ; ignore myself
                         (memq thing (ask pers 'possessions)))
                    (begin
                     (ask pers 'lose thing)
                     (have-fit pers))))
              (ask place 'people))
                 
             (ask thing 'change-possessor self)
             'taken))))

  (method (take-all)
	  (for-each
	   (lambda (thing)
		   (if (eq? (ask thing 'possessor) 'no-one) (ask self 'take thing)))
	   (ask place 'things)))

  (method (lose thing)
    (set! possessions (delete thing possessions))
    (ask thing 'change-possessor 'no-one)
    'lost)
  (method (talk) (print saying))
  (method (set-talk string) (set! saying string))
  (method (exits) (ask place 'exits))
  (method (notice person) (ask self 'talk))
  (method (go direction)
    (let ((new-place (ask place 'look-in direction)))
      (cond ((null? new-place)
	     (error "Can't go" direction))
	    ((not (ask new-place 'may-enter? self)) 
	     (error "The place is locked:" (ask new-place 'name)))
	    (else (ask self 'go-directly-to new-place))))) 
  (method (go-directly-to new-place)
    (ask place 'exit self)
    (announce-move name place new-place)
    (for-each
     (lambda (p)
       (ask place 'gone p)
       (ask new-place 'appear p))
     possessions)
    (set! place new-place)
    (ask new-place 'enter self)))

(define-class (thing name)
  (parent (basic-object))

  (instance-vars
   (possessor 'no-one))
  (method (type) 'thing)
  (method (thing?) #t)
  (method (may-take? receiver)
         (if (eq? possessor 'no-one)
           self
           (and (> (ask receiver 'strength)
                   (ask possessor 'strength))
                self)))
  (method (change-possessor new-possessor)
          (set! possessor new-possessor)))

(define-class (ticket number)
  (parent (thing 'ticket)))

(define-class (laptop name)
  (parent (thing name))
  (method (type) 'laptop)
  (method (connect password)
          (let ((possessor (ask self 'possessor)))
            (if (not (person? possessor))
              (error "The laptop should be picked up by someone before connect"))
            (ask (ask possessor 'place) 'connect self password)))
  (method (surf url)
          (let ((possessor (ask self 'possessor)))
            (if (not (person? possessor))
              (error "The laptop should be picked up by someone before surf"))
            (ask (ask possessor 'place) 'surf self url))))

(define-class (food calories)
  (parent (thing '*food*))
  (initialize
   (ask self 'put 'edible? #t)))

(define-class (bagel)
  (parent (food 250))
  (class-vars
   (name 'bagel)))

(define-class (sushi)
  (parent (food 205))
  (class-vars
   (name 'sushi)))

(define-class (coffee)
  (parent (food 100))
  (class-vars
   (name 'coffee)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Implementation of thieves for part two
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (edible? thing)
  (ask thing 'edible?))

(define-class (thief name initial-place)
  (parent (person name initial-place))
  (initialize (ask self 'put 'strength 100))
  (instance-vars
   (behavior 'steal))
  (method (type) 'thief)

  (method (notice person)
    (if (eq? behavior 'run)
	(let ((exits (ask (usual 'place) 'exits))) 
	  (if (not (null? exits))
	    (ask self 'go (pick-random exits))))
	(let ((food-things
	       (filter (lambda (thing)
			 (and (edible? thing)
			      (not (eq? (ask thing 'possessor) self))))
		       (ask (usual 'place) 'things))))
	  (if (not (null? food-things))
	      (begin
	       (ask self 'take (car food-things))
	       (set! behavior 'run)
	       (ask self 'notice person)) )))) )

(define-class (police name initial-place)
  (parent (person name initial-place))
  (initialize (ask self 'put 'strength 300))

  (method (type) 'police)

  (method (notice person)
          (if (thief? person)
            (begin
             (print "Crime Does Not Pay,")
             (for-each (lambda (the-thing) (ask self 'take the-thing))
                       (ask person 'possessions))
             (ask person 'go-directly-to jail)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Utility procedures
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; this next procedure is useful for moving around

(define (move-loop who)
  (newline)
  (print (ask who 'exits))
  (display "?  > ")
  (let ((dir (read)))
    (if (equal? dir 'stop)
	(newline)
	(begin (ask who 'go dir)
	       (move-loop who)))))


;; One-way paths connect individual places.

(define (can-go from direction to)
  (ask from 'new-neighbor direction to))


(define (announce-take name thing)
  (newline)
  (display name)
  (display " took ")
  (display (ask thing 'name))
  (newline))

(define (announce-move name old-place new-place)
  (newline)
  (newline)
  (display name)
  (display " moved from ")
  (display (ask old-place 'name))
  (display " to ")
  (display (ask new-place 'name))
  (newline))

(define (have-fit p)
  (newline)
  (display "Yaaah! ")
  (display (ask p 'name))
  (display " is upset!")
  (newline))


(define (pick-random set)
  (nth (random (length set)) set))

(define (delete thing stuff)
  (cond ((null? stuff) '())
	((eq? thing (car stuff)) (cdr stuff))
	(else (cons (car stuff) (delete thing (cdr stuff)))) ))

(define (place? obj)
  (and (procedure? obj)
       (ask obj 'place?)))

(define (person? obj)
  (and (procedure? obj)
       (ask obj 'person?)))

(define (thing? obj)
  (and (procedure? obj)
       (ask obj 'thing?)))

(define (restaurant? obj)
  (and (place? obj)
       (eq? (ask obj 'type) 'restaurant)))

(define (laptop? obj)
  (and (thing? obj)
       (eq? (ask obj 'type) 'laptop)))

(define (thief? obj)
  (and (person? obj)
       (eq? (ask obj 'type) 'thief)))

(define (police? obj)
  (and (person? obj)
       (eq? (ask obj 'type) 'police)))

(define (name obj) (ask obj 'name))

(define (inventory obj)
  (if (person? obj)
    (map name (ask obj 'possessions))
    (map name (ask obj 'things))))

(define (whereis person)
  (name (ask person 'place)))

(define (owner thing)
  (let ((maybe-person (ask thing 'possessor)))
    (if (symbol? maybe-person)
      maybe-person
      (name maybe-person))))
