(define (read-file filename)
  (let ((input-port (open-input-file filename)))
    (let loop ((line (read-line input-port)))
         (if (eof-object? line)
           (begin
            (close-input-port input-port)
            '())
           (begin
            (cons-stream (cons filename line) (loop (read-line input-port))))))))

(define data (read-file "../../cs61a/lib/mapreduce/gutenberg/shakespeare_short"))
