(define (segments->painter segment-list)
  (lambda (frame)
          (for-each
           (lambda (segment)
                   (draw-line
                    ((frame-coord-map frame)
                     (start-segment segment))
                    ((frame-coord-map frame)
                     (end-segment segment))))
           segment-list)))

(define outline-painter
  (segments->painter
   (list (make-segment (make-vect 0 0)
                       (make-vect 1 0))
         (make-segment (make-vect 1 0)
                       (make-vect 1 1))
         (make-segment (make-vect 1 1)
                       (make-vect 0 1))
         (make-segment (make-vect 0 1)
                       (make-vect 0 0)))))

(define x-painter
  (segments->painter
   (list (make-segment (make-vect 0 0)
                       (make-vect 1 1))
         (make-segment (make-vect 0 1)
                       (make-vect 1 0)))))

(define diamond-painter
  (segments->painter
   (list (make-segment (make-vect 0 0.5)
                       (make-vect 0.5 0))
         (make-segment (make-vect 0.5 0)
                       (make-vect 1 0.5))
         (make-segment (make-vect 1 0.5)
                       (make-vect 0.5 1))
         (make-segment (make-vect 0.5 1)
                       (make-vect 0 0.5)))))

(define wave
  (segments->painter
   (list (make-segment (make-vect .26 0)
                       (make-vect .37 .56))
         (make-segment (make-vect .37 .56)
                       (make-vect .16 .48))
         (make-segment (make-vect .16 .48)
                       (make-vect 0 .63))
         (make-segment (make-vect 0 .74)
                       (make-vect .16 .61))
         (make-segment (make-vect .16 .61)
                       (make-vect .31 .7))
         (make-segment (make-vect .31 .7)
                       (make-vect .42 .7))
         (make-segment (make-vect .42 .7)
                       (make-vect .31 .83))
         (make-segment (make-vect .31 .83)
                       (make-vect .41 1))
         (make-segment (make-vect .55 1)
                       (make-vect .63 .83))
         (make-segment (make-vect .63 .83)
                       (make-vect .55 .7))
         (make-segment (make-vect .55 .7)
                       (make-vect .68 .7))
         (make-segment (make-vect .68 .7)
                       (make-vect 1 .42))
         (make-segment (make-vect 1 .3)
                       (make-vect .63 .56))
         (make-segment (make-vect .63 .56)
                       (make-vect .79 0))
         (make-segment (make-vect .68 0)
                       (make-vect .53 .3))
         (make-segment (make-vect .53 .3)
                       (make-vect .42 0)))))