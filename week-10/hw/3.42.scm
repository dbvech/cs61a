;; Yes, it is safe. 
;; call to serialize procedure, eg. (protected withdraw) doesn't do any 
;; concurrent operations, serializer just "wraps" the argument procedure
;; and return new procedure, and THAT (returned procedure) is the procedure 
;; with critical section. So there is nothing wrong if we will create it
;; only once, the key point is where it will be invoked - and that part 
;; not changed
