;; Internal (underlying) "map" procedure (added to interpreter by Louis) is 
;; trying to invoke a given procedure (data abstraction from interpreter level) 
;; in underlying Scheme which doesn't know how to handle those data abstractions. 
;; Our represenation of a procedure is different from Scheme's internal. 
;; We store procedures as tagged lists '(procedure FORMALS BODY)
