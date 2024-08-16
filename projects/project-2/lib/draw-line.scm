(define (draw-line start-vect end-vect)
  (graphics-draw-line device
                      (xcor-vect start-vect) (ycor-vect start-vect)
                      (xcor-vect end-vect) (ycor-vect end-vect)))
