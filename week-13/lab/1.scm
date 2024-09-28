(load "../../cs61a/lib/mapreduce/streammapreduce.scm")
(load "../../cs61a/lib/mapreduce/shakespeare_data.scm")

;; the solution is to create different keys (by mapper) to spread reduce operation
;; on multiple instances. Here as example I'm using (random 10) so values from
;; 0 to 9 to get random key instead of static key 'line. After that I combine
;; results using stream-map and stream-accumulate (can be done also using mapreduce
;; BUT we will have only 10 pairs in the end)

(define result (mapreduce (lambda (input-key-value-pair)
                                  (list (make-kv-pair (RANDOM 10) 1)))
                          +
                          0
                          data))

(print (stream-accumulate + 0 (stream-map kv-value result)))
