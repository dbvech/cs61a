(load "twenty-one")
(load "stop-at")
(load "suit-strategy")
(load "play-n")

(play-n
 (suit-strategy 'h (stop-at 17) (stop-at 19))
 10)
