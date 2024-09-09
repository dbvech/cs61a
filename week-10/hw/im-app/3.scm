;; Q: Could #1 have been done with the server doing part of the work? 
;; A: Yes, we can add additional type of message on the server which accepts
;;    receivers list instead of single, and sends the message to all of them.

;; Q: Could #2 have been done entirely in the client code?
;; A: Yes, since on each client we have synced clients-list (which is updated from server) 
;;    We can iterate through list and send message for each client.

;; Q: Compare the virtues of the two approaches.
;; A: There are trade-offs: it's better to resolve both of problems using mostly server, because
;;    in that case we will have only single request FROM client (instead of N requests for list of N clients),
;;    BUT this will require changes on BOTH - client and server codebases, which means we would have to
;;    edit working code, thus we can new introduce new bugs. On the other hand, by making changes only on
;;    the client code, we can eliminate possibility of introducing new bugs, but the network will be
;;    more loaded since we would need to send additional requests TO server (for each client that
;;    needs to receive the message).
