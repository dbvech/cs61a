;; A procedure consist of formal parameters and a body.
;; When we create a procedure there is nothing to eval, we
;; need only store it's parameters, body and env. The moment
;; when we WANT to eval a body of a procedure is the moment 
;; when we INVOKING the procedure (NOT when creating).
