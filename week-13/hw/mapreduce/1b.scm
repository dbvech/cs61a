(load "localmr")

(define (search-words-min-length dirname len)
  (lmapreduce
   (lambda (kvp)
           (map (lambda (wd) (cons wd (kv-key kvp)))
                (filter (lambda (wd) (>= (count wd) len))
                        (kv-value kvp))))
   cons
   '()
   dirname))

(define result (search-words-min-length "/beatles-songs" 7))
(ss result 20)
