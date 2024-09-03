(load "obj")
(load "adv")
(load "tables")
(load "adv-world")

;; Create a new person to represent yourself. Put yourself in a new place 
;; called Dormitory (or wherever you live) and connect it to campus so that you
;; can get there from here.
(define Fallout-111 (instantiate place 'Fallout-111))

(define Dmytro (instantiate person 'Dmytro Fallout-111))

(can-go Intermezzo 'east Fallout-111)
(can-go Fallout-111 'west Intermezzo)

;; Create a place called Kirin, north of Soda. (It's actually on Solano Avenue.)  
(define Kirin (instantiate place 'Kirin))
(can-go Soda 'north Kirin)
(can-go Kirin 'south Soda)

;; Put a thing called Potstickers there.
(define Potstickers (instantiate thing 'Potstickers))
(ask Kirin 'appear Potstickers)

;; Then give the necessary commands to move your character to Kirin
(ask Dmytro 'go 'west) ; Intermezzo
(ask Dmytro 'go 'north) ; Noahs
(ask Dmytro 'go 'north) ; Telegraph-Ave
(ask Dmytro 'go 'north) ; Sproul-Plaza
(ask Dmytro 'go 'north) ; Pimentel
(ask Dmytro 'go 'north) ; Soda
(ask Dmytro 'go 'north) ; Kirin

;; take the Potstickers
(ask Dmytro 'take Potstickers)

;; then move yourself to where Brian is 
(ask Dmytro 'go 'south) ; Soda
(ask Dmytro 'go 'up) ; art-gallery
(ask Dmytro 'go 'west) ; BH-office

;; put down the Potstickers, 
(ask Dmytro 'lose Potstickers)

;; and have Brian take them 
(ask Brian 'take Potstickers)

;; Then go back to the lab and get back to work.
(ask Dmytro 'go 'east) ; art-gallery
(ask Dmytro 'go 'down) ; Soda
(ask Dmytro 'go 'south) ; Pimentel
(ask Dmytro 'go 'south) ; 61A-Lab
