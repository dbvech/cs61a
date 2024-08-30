;; Consider the following make-cycle procedure, which uses the last-pair procedure defined in Exercise 3.12:

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

;; Draw a box-and-pointer diagram that shows the structure z created by
(define z (make-cycle (list 'a 'b 'c)))

;;         +-------------------------------+
;;         |                               |
;;         V                               |
;;  z  +---+---+    +---+---+    +---+---+ |
;; --->| o | o +--->| o | o +--->| o | o +-+
;;     +-+-+---+    +-+-+---+    +-+-+---+
;;       |            |            |      
;;       |            |            |      
;;       V            V            V      
;;       a            b            c      

;; What happens if we try to compute (last-pair z)?
;; - infinite loop, the program will never finished
