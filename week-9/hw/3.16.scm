(count-pairs (list 'a 'b 'c))
;; => 3

;;     +---+---+    +---+---+    +---+---+
;; --->| o | o +--->| o | o +--->| o | / |
;;     +-+-+---+    +-+-+---+    +-+-+---+
;;       |            |            |
;;       V            V            V
;;       a            b            c




(define lst (list (cons 'a '()) 'b))
(set-cdr! (car lst) (cdr lst))
(count-pairs lst)
;; => 4

;;     +---+---+    +---+---+
;; --->| o | o +--->| o | / |
;;     +-+-+---+    +-+-+---+
;;       |            |  ^    
;;       V            V  |    
;;     +---+---+      b  |
;;     | o | o +----------
;;     +-+-+---+
;;       |
;;       V
;;       a




(define a (cons 'a '()))
(define b (cons a a))
(define c (cons b b))
(count-pairs c)
;; => 7

;;     +---+---+
;; --->| o | o |
;;     +-+-+-+-+
;;       |   |
;;       V   V
;;     +---+---+
;;     | o | o |
;;     +-+-+-+-+
;;       |   |
;;       V   V
;;     +---+---+
;;     | o | / |
;;     +-+-+---+
;;       |
;;       V
;;       a




NEVER return
(define lst (list 'a 'b 'c))
(set-cdr! (cddr lst) (cdr lst))
(count-pairs lst)
;; =>

;;                        --------------
;;                        |            |
;;                        V            |
;;     +---+---+    +---+---+    +---+-+-+
;; --->| o | o |--->| o | o +--->| o | o |
;;     +-+-+---+    +-+-+---+    +-+-+---+
;;       |            |            |
;;       V            V            V
;;       a            b            c
