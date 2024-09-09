;; im-client.scm
(define (im-to-list who-list message)
  (if (empty? who-list)
    #t
    (and
     (im (car who-list) message)
     (im-to-list (cdr who-list) message))))
