;; QUEUE data type
(define (make-queue) (cons '() '()))

;; selectors
(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (front-queue queue)
  (if (empty-queue? queue)
    (error "FRONT called with an 
              empty queue" queue)
    (car (front-ptr queue))))

;; mutators
(define (set-front-ptr! queue item)
  (set-car! queue item))
(define (set-rear-ptr! queue item)
  (set-cdr! queue item))

(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
      (else (set-cdr! (rear-ptr queue)
                      new-pair)
            (set-rear-ptr! queue new-pair)
            queue))))

(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with 
                 an empty queue" queue))
    (else (set-front-ptr!
           queue
           (cdr (front-ptr queue)))
          queue)))

;; helpers
(define (empty-queue? queue)
  (null? (front-ptr queue)))

(define q1 (make-queue))

(insert-queue! q1 'a)
;; => ((a) a)

(insert-queue! q1 'b)
;; => ((a b) b)

(delete-queue! q1)
;; => ((b) b)

(delete-queue! q1)
;; => (() b)


;; the reason why it has such output as above is that queue itself is a pair with 
;; two pointers (front and rear), so when we insert first char (insert-queue! q1 'a) 
;; it becomes this structure

;;  q1 +---+---+
;; --->| o | o |
;;     +-+-+-+-+
;;       |   |   
;;       |   |   
;;       V   V   
;;     +---+---+
;;     | o | / |
;;     +-+-+---+
;;       |
;;       |
;;       V
;;       a
;;
;; so, both car and cdr of q1 is pointing to same pair (with car of 'a), that is why it has output
;; => ((a) a)
;;
;; on second call (insert-queue! q1 'b), it has this structure

;;  q1 +---+---+
;; --->| o | o |
;;     +-+-+-+-+
;;       |   |   
;;       |   +--------+   
;;       V            V  
;;     +---+---+    +---+---+
;;     | o | o +--->| o | / |
;;     +-+-+---+    +-+-+---+
;;       |            |
;;       |            |
;;       V            V
;;       a            b
;; 
;; so the output for q1 is
;; => ((a b) b)

;; and so on...
;; So, to fix the output we need to ignore pointers which constructs the queue and instead return the underlying list
(define (print-queue queue)
  (front-ptr queue))
;; or just (define print-queue front-ptr)

(define q1 (make-queue))

(insert-queue! q1 'a)
;; => ((a) a)
(print-queue q1)
;; => (a)

(insert-queue! q1 'b)
;; => ((a b) b)
(print-queue q1)
;; => (a b)

(delete-queue! q1)
;; => ((b) b)
(print-queue q1)
;; => (b)

(delete-queue! q1)
;; => (() b)
(print-queue q1)
;; => ()
