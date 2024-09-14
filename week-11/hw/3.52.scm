;; Consider the sequence of expressions

(define sum 0)
;; sum is 0 here

(define (accum x)
  (set! sum (+ x sum))
  sum)
;; sum is 0 here

(define seq
  (stream-map
   accum
   (stream-enumerate-interval 1 20)))
;; sum is 1 here, because stream-map proc applied accum procedure to stream-car 
;; of stream-enumerate-interval from 1 to 20

(define y (stream-filter even? seq))
;; sum is 6 here 
;; 1st element of seq is 1 - not even
;; it will force 2nd element which will be 3 - not even
;; 3rd element will be 6 - even, here stream-filter "stops"
;; calculated values for seq here is (1 3 6 delayed-obj)
;; calculated values for y here is (6 delayed-obj)

(define z
  (stream-filter
   (lambda (x)
           (= (remainder x 5) 0)) seq))
;; calculated values for seq is (1 3 6 10 delayed-obj)
;; calculated values for z is (10 delayed-obj)
;; sum is 10 here

(stream-ref y 7)
;; => 136
;; sum is 136
;; calculated values for seq (1 3 6 10 15 21 28 36 45 55 66 78 91 105 120 136 delayed-obj)
;; calculated values for y (6 10 28 36 66 78 120 136)

(display-stream z)
;; => 10
;; => 15
;; => 45 
;; => 55
;; => 105 
;; => 120
;; => 190 
;; => 210
;; => done
;; sum is 210 here

;; Would these responses differ if we had 
;; implemented (delay ⟨exp⟩) simply as (lambda () ⟨exp⟩) without using the 
;; optimization provided by memo-proc? Explain.

;; ANSWER: Yes, it would differ, because both streams - z and y are built 
;; "on top" of seq stream which is stream-map accum, thus underlying map
;; will be invoking accum procedure EACH time we iterate through it instead of
;; using memoized value. Accum procedure in it's turn is not a function, 
;; it changes outside (global) variable sum and then returns it to use as
;; element of seq stream. So, each invokation of 
;; (stream-car (stream-cdr seq)) 
;; will give different values, because of accumulative effect on sum variable

