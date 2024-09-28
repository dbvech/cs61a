(load "../../cs61a/lib/mapreduce/streammapreduce.scm")
(load "../../cs61a/lib/mapreduce/shakespeare_data.scm")

(load "3a")

;; I searched here different patterns than in the lab, cause I have smaller
;; data for Shakespeare (like first 2500 lines), and I'm not using distributed
;; mapreduce.

(define result1 (search '(* on darkness which *) data))
(define result2 (search '(* shadow *) data))
