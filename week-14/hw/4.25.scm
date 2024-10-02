;; applicative order: the interpreter will never fall into "unless" procedure,
;; cause it will execute all the args of it, and one of the args is recursive 
;; call to factorial, so it is an infinite loop.

;; normal order: this definitions will work, the interpreter will evaluate 
;; recursive call to factorial only when it will be needed (lazy).
