(define sproul-hall-exit
  (let ((count 0))
    (lambda ()
            (set! count (+ count 1))
            (if (> count 3)
              (print "Alright, you can go now!")
              (error "You can check out any time you'd like, but you can never leave")))))
