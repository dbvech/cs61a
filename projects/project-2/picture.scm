(load-option 'x11)
(load "lib/vector")
(load "lib/frame")
(load "lib/segment")
(load "lib/painters")
(load "lib/transforms")

(define full-frame (make-frame (make-vect -0.5 -0.5)
                               (make-vect 2 0)
                               (make-vect 0 2)))

(define device (make-graphics-device (car (enumerate-graphics-types))))
(graphics-set-coordinate-limits device -.5 -.5 1.5 1.5)

;; (wave full-frame)
;; ((rotate90 wave) full-frame)
;; ((below wave wave) full-frame)
;; ((below2 x-painter wave) full-frame)
((square-limit wave 3) full-frame)
