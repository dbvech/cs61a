;; Program to solve triangles given partial information.

;; Form of invocation is (triangle side1 side2 side3 angle1 angle2 angle3)
;;   where each argument is zero if the corresponding side or angle is
;;   unknown.  Angles are entered in degrees (but converted internally
;;   to radians).  Angle1 is opposite side1, etc.  The program must be
;;   given at least three knowns, at least one of which must be a side.

;; First, here are some useful definitions from trig class:

(define pi 3.14159)

(define (square x) (* x x))

(define (degrees rad) (* 180 (/ rad pi)))

(define (radians deg) (* pi (/ deg 180)))

(define (arcsin a) (atan a (sqrt (- 1 (square a)))))

(define (arccos a) (atan (sqrt (- 1 (square a))) a))

;; This is the top-level procedure

(define (triangle a b c alpha beta gamma)

  (define (triangle-rad a b c alpha beta gamma)

;; The strategy is to keep increasing the number of sides we know, and at
;; the end to make sure we know the angles too.  Here are some local
;; procedures to count how many sides we know.  They are predicates that
;; return true if we know at least so many sides (or angles sometimes).

    (define (havethreesides) (not (or (= a 0) (= b 0) (= c 0))))

    (define (havetwo a b c)
      (cond ((= a 0) (not (or (= b 0) (= c 0))))
	    (else (not (and (= b 0) (= c 0))))))
    (define (havetwosides) (havetwo a b c))
    (define (havetwoangles) (havetwo alpha beta gamma))

    (define (haveone a b c)
      (not (and (= a 0) (= b 0) (= c 0))))
    (define (haveoneside) (haveone a b c))
    (define (haveoneangle) (haveone alpha beta gamma))

;; If we know all three sides we can use the law of cosines to find
;; any angles that might be missing.

    (define (solvethreesides)
      (define (lawcosangle side1 side2 hyp)
      	(arccos (/ (- (+ (square side1) (square side2)) (square hyp))
	      (* 2 side1 side2))))
      (define (sidesbad)
	(define (tri-ineq a b c) (> (+ a b) c))
	(not (and (tri-ineq a b c) (tri-ineq a c b) (tri-ineq b c a))))

      (cond ((sidesbad) "Your sides fail the triangle inequality.")
	    ((= alpha 0)
	     (triangle-rad a b c (lawcosangle b c a) beta gamma))
	    ((= beta 0)
	     (triangle-rad a b c alpha (lawcosangle a c b) gamma))
	    ((= gamma 0)
	     (triangle-rad a b c alpha beta (lawcosangle a b c)))
	    (else
	     (list a b c (degrees alpha) (degrees beta) (degrees gamma)))))

;; [You don't know about the procedure "list" yet, but it lets us return
;; more than one number in a single result.]

;; We invoke this procedure if we know two sides:

    (define (solvetwosides)

;; It'll make life easier if we rearrange things so that side C is unknown.

      (cond ((not (haveoneangle)) "Must know at least three values.")
	    ((= a 0) (triangle-rad b c a beta gamma alpha))
	    ((= b 0) (triangle-rad a c b alpha gamma beta))
	    (else "YOU FILL IN THE REST!")))

;; This is the executable body of triangle-rad:

    (cond ((havethreesides) (solvethreesides))
	  ((havetwosides) (solvetwosides))
	  ((haveoneside) (solveoneside))
	  (else "Must know at least one side.")))

;; This is the executable body of triangle.

  (cond ((> (+ alpha beta gamma) 180)
	 "Your angles add up to more than 180.")
  	(else (triangle-rad a b c
			    (radians alpha) (radians beta) (radians gamma)))))
