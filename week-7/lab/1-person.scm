(load "../../cs61a/lib/obj")

(define-class (person name)
  (instance-vars (last-said '()))
  (method (say stuff)
          (set! last-said stuff)
          stuff)
  (method (repeat)
          last-said)
  (method (ask stuff) (ask self 'say (se '(would you please) stuff)))
  (method (greet) (ask self 'say (se '(hello my name is) name))))

(define brian (instantiate person 'brian))
(ask brian 'repeat)
(ask brian 'say '(hello))
(ask brian 'repeat)
(ask brian 'greet)
(ask brian 'repeat)
(ask brian 'ask '(close the door))
(ask brian 'repeat)
