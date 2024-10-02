;; ramb data abstraction helpers
(define (ramb? exp) (tagged-list? exp 'ramb))
(define (ramb-choices exp) (cdr exp))

;; handle ramb expression in analyze procedure
((ramb? exp) (analyze-ramb exp))

;;;ramb expressions
(define (analyze-ramb exp)
  (define (remove-from-list ref choices)
    (define (loop i choices-left)
      (cond
        ((null? choices-left) '())
        ((= i ref) (cdr choices-left))
        (else (cons (car choices-left)
                    (loop (+ i 1) (cdr choices-left))))))
    (loop 0 choices))
  (let ((cprocs (map analyze (ramb-choices exp))))
    (lambda (env succeed fail)
            (define (try-next choices)
              (if (null? choices)
                (fail)
                (let ((rand (random (length choices))))
                  ((list-ref choices rand)
                   env
                   succeed
                   (lambda ()
                           (try-next (remove-from-list rand choices)))))))
            (try-next cprocs))))

;; changing amb->ramb in parse-word can help with Alyssa’s problem in Exercise 4.49
(define (parse-word word-list)
  (define (loop words)
    (require (not (null? words)))
    (RAMB (car words) (loop (cdr words))))
  (list (car word-list) (loop (cdr word-list))))
