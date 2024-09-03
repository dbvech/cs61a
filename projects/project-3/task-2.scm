(load "obj")
(load "adv")
(load "tables")
(load "adv-world")

;; 2A. What kind of thing is the value of variable BRIAN?
;; ANSWER: dispatch procedure (instance of person)


;; 2B. List all the messages that a PLACE understands.  (You might want to
;; maintain such a list for your own use, for every type of object, to help
;; in the debugging effort.)
;; ANSWER: 
;; Instantiation vars:
;; - name
;; Instance vars:
;; - directions-and-neighbors
;; - things
;; - people
;; - entry-procs
;; - exit-procs
;; Methods 
;; - type,
;; - neighbors
;; - exits
;; - look-in
;; - appear
;; - enter
;; - gone
;; - exit
;; - new-neighbor
;; - add-entry-procedure
;; - add-exit-procedure
;; - remove-entry-procedure 
;; - remove-exit-procedure
;; - clear-all-procs


;; 2C.   We have been defining a variable to hold each object in our world.
;; For example, we defined bagel by saying:
;;
;;      (define bagel (instantiate thing 'bagel))
;;
;; This is just for convenience.  Every object does not have to have a
;; top-level definition.  Every object DOES have to be constructed and
;; connected to the world.  For instance, suppose we did this:
;;
;; > (can-go Telegraph-Ave 'east (instantiate place 'Peoples-Park))
;;
;; ;;; assume BRIAN is at Telegraph
;; > (ask Brian 'go 'east)
;;
;; What is returned by the following expressions and WHY?
;;
;; > (ask Brian 'place)
;; => procedure
;; WHY: will return dispatch procedure (instance of place with name 'Peoples-Park'),
;;      because "place" is an instantiation variable of "class" person, and it holds pointer to place instance
;;
;; > (let ((where (ask Brian 'place)))
;;        (ask where 'name))
;; => 'peoples-park'
;; WHY: "where" variable will hold pointer to instance (of place) where Brian is, so pointer to procedure 'Peoples-Park',
;;      then we ask it ("where") for instantiation variable 'name', so returned value is 'peoples-park'
;;
;; >  (ask Peoples-park 'appear bagel)
;; => error: unbound variable 'Peoples-park'
;; WHY: we didn't bind (via define) 'Peoples-park' instance (of place) to a variable, so it will throw an error


;; 2D.  The implication of all this is that there can be multiple names for
;; objects.  One name is the value of the object's internal NAME variable. In
;; addition, we can define a variable at the top-level to refer to an object.
;; Moreover, one object can have a private name for another object.  For
;; example, BRIAN has a variable PLACE which is currently bound to the object
;; that represents People's Park.  Some examples to think about:
;;
;;       > (eq? (ask Telegraph-Ave 'look-in 'east) (ask Brian 'place))
;;       => #t
;;       cause both procedures "ask" will return pointer to same instance of place with name 'Peoples-Park'
;;
;;       > (eq? (ask Brian 'place) 'Peoples-Park)
;;       => #f 
;;       (ask Brian 'place) will return pointer to instance (procedure) and it is not eq? to symbol 'Peoples-Park
;;
;;       > (eq? (ask (ask Brian 'place) 'name) 'Peoples-Park)
;;       => #t
;;       (ask (ask Brian 'place) 'name) will return symbol 'Peoples-Park and it is eq to second arg 'Peoples-Park,
;;       cause in Scheme two equal symbols are also eq
;;            
;;
;;
;; OK.  Suppose we type the following into scheme:
;;
;; >  (define computer (instantiate thing 'Durer))
;;
;;
;; Which of the following is correct?  Why?
;;
;; (ask 61a-lab 'appear computer)  <- THIS ONE IS CORRECT
;;
;; or
;;
;; (ask 61a-lab 'appear Durer) WRONG: No variable with name Durer
;;
;; or 
;;
;; (ask 61a-lab 'appear 'Durer) WRONG: need to pass instance (procedure) as arg instead of it's symbol name
;;
;; What is returned by (computer 'name)?  Why?
;; ANSWER: will return procedure, which if we will execute then will return a name of thing. Every variable and method of objects
;;         returns procedure (for convenience) to have ability to pass args. So if we will invoke it like so ((computer 'name))
;;         then it will return symbol 'durer


;; 2E.  We have provided a definition of the THING class that does not use
;; the object-oriented programming syntax described in the handout.  Translate
;; it into the new notation.
(define-class (thing name)
  (instance-vars
   (possessor 'no-one))
  (method (type) 'thing)
  (method (change-possessor new-possessor)
          (set! possessor new-possessor)))

;; 2F.  Sometimes it's inconvenient to debug an object interactively because
;; its methods return objects and we want to see the names of the objects.  You
;; can create auxiliary procedures for interactive use (as opposed to use
;; inside object methods) that provide the desired information in printable
;; form.  For example:
;;
;; (define (name obj) (ask obj 'name))
;; (define (inventory obj)
;;   (if (person? obj)
;;       (map name (ask obj 'possessions))
;;       (map name (ask obj 'things))))

;; Write a procedure WHEREIS that takes a person as its argument and returns
;; the name of the place where that person is.

(define (name obj) (ask obj 'name))

(define (whereis person)
  (name (ask person 'place)))

;; Write a procedure OWNER that takes a thing as its argument and returns the
;; name of the person who owns it.  (Make sure it works for things that aren't
;; owned by anyone.)

(define (owner thing)
  (let ((maybe-person (ask thing 'possessor)))
    (if (symbol? maybe-person)
      maybe-person
      (name maybe-person))))
