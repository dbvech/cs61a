(stream-cdr (stream-cdr (cons-stream 1 '(2 3))))

;; Evaluation:
;; 1. '(2 3) is a list (2 3)
;; 2. (cons-stream 1 '(2 3)) will return a stream (1 promise)
;; 3. take a stream-cdr of that stream will exec the promise and return
;;    the list (2 3)
;; 4. invoking outer stream-cdr on the list will throw an error, cause 
;;    stream-cdr will try to execute `force` on cdr of the list (2 3), 
;;    which is 3
