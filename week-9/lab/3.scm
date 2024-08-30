;; 3a

(define list1 (list (list 'a) 'b))
(define list2 (list (list 'x) 'y))

(set-cdr! (car list2) (cdr list1))

(set-cdr! (car list1) (car list2))


;; 3b
;; Initial representation of list1 and list2 (before mutations)

;; list1 +---+---+    +---+---+     list2 +---+---+    +---+---+ 
;; ----->| o | o +--->| o | / |     ----->| o | o +--->| o | / | 
;;       +-+-+---+    +-+-+---+           +-+-+---+    +-+-+---+ 
;;         |            |                   |            |       
;;         |            |                   |            |       
;;         |            V                   |            V       
;;         |            b                   |            y       
;;         V                                V
;;       +---+---+                        +---+---+              
;;       | o | / |                        | o | / |              
;;       +-+-+---+                        +-+-+---+              
;;         |                                |                    
;;         |                                |                    
;;         V                                V                    
;;         a                                x                    


;; After mutations initial mutations

;; list1 +---+---+    +---+---+     list2 +---+---+    +---+---+ 
;; ----->| o | o +--->| o | / |     ----->| o | o +--->| o | / | 
;;       +-+-+---+    +-+-+---+           +-+-+---+    +-+-+---+ 
;;         |            |   ^               |            |       
;;         |            |   |               |            |       
;;         |            V   |               |            V       
;;         |            b   |               |            y       
;;         V                |               V
;;       +---+---+          |             +---+---+              
;;       | o | o +----------+------------>| o | o |              
;;       +-+-+---+          |             +-+-+-+-+              
;;         |                |               |   |                
;;         |                |               |   |                
;;         V                |               V   |                
;;         a                |               x   |                
;;                          |                   |
;;                          +-------------------+

(set-car! (cdr list1) (cadr list2))
;; ^ this one will just change the value of the second element of list1 to "y" (cadr list2)

;; list1 +---+---+    +---+---+     list2 +---+---+    +---+---+ 
;; ----->| o | o +--->| o | / |     ----->| o | o +--->| o | / | 
;;       +-+-+---+    +-+-+---+           +-+-+---+    +-+-+---+ 
;;         |            |   ^               |            |       
;;         |            |   |               |            |       
;;         |            V   |               |            V       
;;         |            y   |               |            y       
;;         V                |               V
;;       +---+---+          |             +---+---+              
;;       | o | o +----------+------------>| o | o |              
;;       +-+-+---+          |             +-+-+-+-+              
;;         |                |               |   |                
;;         |                |               |   |                
;;         V                |               V   |                
;;         a                |               x   |                
;;                          |                   |
;;                          +-------------------+