;; reading value is a single (atomic) operation so it can't interleave with 
;; other processes, thus it is NOT required to use a serializer for it.
