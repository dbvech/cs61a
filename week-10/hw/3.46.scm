;; Suppose that we implement test-and-set! using an ordinary procedure as shown 
;; in the text, without attempting to make the operation atomic. Draw a timing 
;; diagram like the one in Figure 3.29 to demonstrate how the mutex 
;; implementation can fail by allowing two processes to acquire the mutex 
;; at the same time.

(define (make-serializer)
  (let ((mutex (make-mutex)))
    (lambda (p)
            (define (serialized-p . args)
              (mutex 'acquire)
              (let ((val (apply p args)))
                (mutex 'release)
                val))
            serialized-p)))

(define (make-mutex)
  (let ((cell (list false)))
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
               (the-mutex 'acquire))) ; retry
            ((eq? m 'release) (clear! cell))))
    the-mutex))

(define (clear! cell) (set-car! cell false))

(define (test-and-set! cell)
  (if (car cell)
    true
    (begin (set-car! cell true)
           false)))

;; The issue here is that process A can start acquiring the mutex,
;; mutex will read value of cell, which is #f (mutex is free), and 
;; BEFORE mutex will change the value of cell, process B can acquire
;; same mutex cause cell is #f still. 

;;      Process A           Mutex           Process B
;;         |               cell: #f             |        
;;         |                                    |        
;;         v                                    |        
;;  (mutex 'acquire)                            v
;;         |                             (mutex 'acquire)
;;         |                                    |
;;         v                                    |
;;  (car cell) -> #f                            v
;;         |                            (car cell) -> #f 
;;         |                                    |
;;         v                                    |
;; (set-car! cell #t)                           v
;;         |                            (set-car! cell #t)
;;         |                                    |
;;         +----------------> #t                |
;;         |                  #t <--------------+
;;         |                                    |
;;         v                                    v
;;  critical section                      critical section
