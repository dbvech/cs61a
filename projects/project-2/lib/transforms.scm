(define (transform-painter
         painter origin corner1 corner2)
  (lambda (frame)
          (let ((m (frame-coord-map frame)))
            (let ((new-origin (m origin)))
              (painter (make-frame new-origin
                                   (sub-vect (m corner1)
                                             new-origin)
                                   (sub-vect (m corner2)
                                             new-origin)))))))

(define (identity painter) painter)

(define (flip-vert painter)
  (transform-painter
   painter
   (make-vect 0.0 1.0)
   (make-vect 1.0 1.0)
   (make-vect 0.0 0.0)))

(define (flip-horiz painter)
  (transform-painter
   painter
   (make-vect 1.0 0.0)
   (make-vect 0.0 0.0)
   (make-vect 1.0 1.0)))

(define (shrink-to-upper-right painter)
  (transform-painter painter
                     (make-vect 0.5 0.5)
                     (make-vect 1.0 0.5)
                     (make-vect 0.5 1.0)))

(define (rotate90 painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define (rotate180 painter)
  (transform-painter painter
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 0.0)))

(define (rotate270 painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

(define (squash-inwards painter)
  (transform-painter painter
                     (make-vect 0.0 0.0)
                     (make-vect 0.65 0.35)
                     (make-vect 0.35 0.65)))

(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left (transform-painter
                       painter1
                       (make-vect 0.0 0.0)
                       split-point
                       (make-vect 0.0 1.0)))
          (paint-right (transform-painter
                        painter2
                        split-point
                        (make-vect 1.0 0.0)
                        (make-vect 0.5 1.0))))
      (lambda (frame)
              (paint-left frame)
              (paint-right frame)))))

(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-bottom (transform-painter
                         painter1
                         (make-vect 0.0 0.0)
                         (make-vect 1.0 0.0)
                         split-point))
          (paint-top (transform-painter
                      painter2
                      split-point
                      (make-vect 1.0 0.5)
                      (make-vect 0.0 1.0))))
      (lambda (frame)
              (paint-bottom frame)
              (paint-top frame)))))

(define (below2 painter1 painter2)
  (rotate90
   (beside (rotate270 painter1)
           (rotate270 painter2))))

(define (square-of-four tl tr bl br)
  (lambda (painter)
          (let ((top (beside (tl painter)
                             (tr painter)))
                (bottom (beside (bl painter)
                                (br painter))))
            (below bottom top))))

(define (up-split painter n)
  (if (= n 0)
    painter
    (let ((smaller (up-split painter
                             (- n 1))))
      (below painter
             (beside smaller smaller)))))

(define (right-split painter n)
  (if (= n 0)
    painter
    (let ((smaller (right-split painter
                                (- n 1))))
      (beside painter
              (below smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
    painter
    (let ((up (up-split painter (- n 1)))
          (right (right-split painter
                              (- n 1))))
      (let ((top-left (beside up up))
            (bottom-right (below right
                                 right))
            (corner (corner-split painter
                                  (- n 1))))
        (beside (below painter top-left)
                (below bottom-right
                       corner))))))

(define (square-limit painter n)
  (let ((combine4
         (square-of-four flip-horiz
                         identity
                         rotate180
                         flip-vert)))
    (combine4 (corner-split painter n))))
