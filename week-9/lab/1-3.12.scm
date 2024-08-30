(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (cdr x))
    x
    (last-pair (cdr x))))


(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))

;; at this stage we have the following box-and-pointers diagram

;;  x  +---+---+    +---+---+      y  +---+---+    +---+---+
;; --->| o | o +--->| o | / |     --->| o | o +--->| o | / |
;;     +-+-+---+    +-+-+---+         +-+-+---+    +-+-+---+
;;       |            |                 |            |
;;       |            |                 |            |
;;       V            V                 V            V
;;       a            b                 c            d
;;
;;  z  +---+---+    +---+---+    +---+---+    +---+---+
;; --->| o | o +--->| o | o +--->| o | o +--->| o | / |
;;     +-+-+---+    +-+-+---+    +-+-+---+    +-+-+---+
;;       |            |            |            |
;;       |            |            |            |
;;       V            V            V            V
;;       a            b            c            d

z
;; -> (a b c d)

(cdr x)
;; -> (b) , nothing changed, X still pointing to same list (a b), procedure append is not a mutator

(define w (append! x y))

;; now we mutated list X, by adding Y list to the end of it. List W points to same list as X

;; x,w +---+---+    +---+---+    +---+---+    +---+---+
;; --->| o | o +--->| o | o +--->| o | o +--->| o | / |
;;     +-+-+---+    +-+-+---+    +-+-+---+    +-+-+---+
;;       |            |            |            |
;;       |            |            |            |
;;       V            V            V            V
;;       a            b            c            d
;;
;;  z  +---+---+    +---+---+    +---+---+    +---+---+
;; --->| o | o +--->| o | o +--->| o | o +--->| o | / |
;;     +-+-+---+    +-+-+---+    +-+-+---+    +-+-+---+
;;       |            |            |            |
;;       |            |            |            |
;;       V            V            V            V
;;       a            b            c            d

w
;; -> (a b c d)

(cdr x)
;; -> (b c d) , cause we modified list X with append!, so now X and Z points to same list (a b c d)
