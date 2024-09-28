(load "../../cs61a/lib/mapreduce/streammapreduce.scm")
(load "../../cs61a/lib/mapreduce/shakespeare_data.scm")

(define (normalize wd)
  (let* ((str (string-downcase
               (cond
                 ((number? wd) (number->string wd))
                 ((symbol? wd) (symbol->string wd))
                 (else wd))))
         (last-char (string-ref str (- (string-length str) 1))))
        (if (string-find? (string last-char) ":;,.!?")
          (substring str 0 (- (string-length str) 1))
          str)))

(define (mapper input-key-value-pair)
  (map (lambda (w) (make-kv-pair (normalize w) 1))
       (kv-value input-key-value-pair)))

(define gutenberg-wordcounts (mapreduce mapper + 0 data))
