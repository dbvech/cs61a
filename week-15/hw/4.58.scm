(assert! (rule (big-shot ?p ?div)
               (and (job ?p (?div . ?any1))
                    (not (and (supervisor ?p ?boss)
                              (job ?boss (?div . ?any2)))))))
