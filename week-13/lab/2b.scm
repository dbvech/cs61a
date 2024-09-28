(load "2a")

(define (find-max-mapper kv-pair)
  (list (make-kv-pair (first (kv-key kv-pair))
                      kv-pair)))

(define (find-max-reducer current so-far)
  (if (> (kv-value current) (kv-value so-far))
    current
    so-far))

(define frequent (mapreduce find-max-mapper find-max-reducer
                            (make-kv-pair 'foo 0) gutenberg-wordcounts))

(define most-used-word
  (stream-accumulate find-max-reducer (make-kv-pair 'foo 0)
                     (stream-map kv-value frequent)))

(print most-used-word) ;; print the kv-pair (WORD . COUNT)
(print (kv-key most-used-word)) ;; print the word itself
