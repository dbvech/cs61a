(load "2a")

(define words-used-once
  (stream-map kv-key
              (stream-filter (lambda (p) (= (kv-value p) 1))
                             gutenberg-wordcounts)))

(ss words-used-once 10)
