(car ''abracadabra)

;; when interpreter evaluates this expression, it transform this
;; ''abracadabra into (quote (quote abracadabra)) 
;; a `quote` is a special form. Thus the outer `quote` makes a list with
;; two symbols data - `quote` and `abracadabra`
;; (quote (quote abracadabra)) is the same as '(quote abracadabra)
;; In result the whole expression (car '(quote abracadabra)) will return `quote`
;; as "left" (car) element of list (quote abracadabra)
