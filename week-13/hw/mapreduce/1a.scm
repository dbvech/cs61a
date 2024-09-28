(load "localmr")

(define (search-words dirname)
  (lmapreduce
   (lambda (kvp)
           (map (lambda (wd) (cons wd (kv-key kvp)))
                (kv-value kvp)))
   cons
   '()
   dirname))

;; (define result (search-words "/beatles-songs"))
;; (ss result 20)
