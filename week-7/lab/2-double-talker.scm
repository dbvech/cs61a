(define-class (double-talker name)
  (parent (person name))
  (method (say stuff) (se (usual 'say stuff) (ask self 'repeat))))
;; repeat method is not working here as desired, since we "store" not doubled version of stuff

(define-class (double-talker name)
  (parent (person name))
  (method (say stuff) (se stuff stuff)))
;; repeat functionality is broken here, since we redefined here "say" method, and it doesn't store prev message

(define-class (double-talker name)
  (parent (person name))
  (method (say stuff) (usual 'say (se stuff stuff))))
;; this one works as expected

(define mike (instantiate double-talker 'mike))
(ask mike 'say '(hello))
(ask mike 'say '(the sky is falling))
(ask mike 'repeat)
