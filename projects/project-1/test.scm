(define (stringify val)
  (cond
    ((string? val) val)
    ((number? val) (number->string val))
    ((boolean? val) (if val "true" "false"))
    (else (error "Unknown type"))))

(define (test name actual expected)
  (if (eq? actual expected)
    (string-append "✅ " name)
    (error (string-append
            "\n❌ " name
            "\nExpected: "
            (stringify expected)
            ", but got: "
            (stringify actual)))))
