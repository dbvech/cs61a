(define (mystery x)
  (define (loop x y)
    (if (null? x)
      y
      (let ((temp (cdr x)))
        (set-cdr! x y)
        (loop temp x))))
  (loop x '()))


(define v (list 'a 'b 'c 'd))

;;  v  +---+---+    +---+---+    +---+---+    +---+---+
;; --->| o | o +--->| o | o +--->| o | o +--->| o | / |
;;     +-+-+---+    +-+-+---+    +-+-+---+    +-+-+---+
;;       |            |            |            |      
;;       |            |            |            |      
;;       V            V            V            V      
;;       a            b            c            d      
;;


(define w (mystery v))

;; v,w +---+---+    +---+---+    +---+---+    +---+---+            
;; --->| o | o +--->| o | o +--->| o | o +--->| o | / |            
;;     +-+-+---+    +-+-+---+    +-+-+---+    +-+-+---+            
;;       |            |            |            |                  
;;       |            |            |            |                  
;;       V            V            V            V                  
;;       d            c            b            a                  
;;

;; the mystery procedure is reverting (and mutating) a given list
;; the output for both - v and w will be
;; -> (d c b a)
