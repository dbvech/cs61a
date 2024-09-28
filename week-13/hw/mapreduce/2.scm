(load "localmr")

;; helpers
(define (stream-take-first n s)
  (if (or (= n 0) (null? (stream-cdr s)))
    '()
    (cons-stream (stream-car s)
                 (stream-take-first (- n 1) (stream-cdr s)))))

(define (stream-flatten s)
  (define (loop current)
    (if (null? current)
      (stream-flatten (stream-cdr s))
      (cons-stream (car current) (loop (cdr current)))))
  (if (null? s)
    '()
    (loop (stream-car s))))

;; email data abstraction selectors
(define email-from car)
(define email-to cadr)
(define email-subject caddr)
(define email-body cadddr)

;; 2(a)
(define subjects-usage
  (lmapreduce
   (lambda (kvp) (list (make-kv-pair (email-subject (kv-value kvp)) 1)))
   +
   0
   "/sample-emails"))

;; 2(b)
(define sorted-subjects-usage
  (stream-map kv-value
              (lmapreduce
               (lambda (kvp) (list (make-kv-pair (- (kv-value kvp)) kvp)))
               cons
               '()
               subjects-usage)))

(define most-common-subjects
  (stream->list
   (stream-take-first 10
                      (stream-flatten sorted-subjects-usage))))

;; 2(c)
(define spammers
  (lmapreduce
   (lambda (kvp)
           (if (assoc (email-subject (kv-value kvp)) most-common-subjects)
             (list (make-kv-pair (email-from (kv-value kvp)) 1))
             '()))
   +
   0
   "/sample-emails"))
