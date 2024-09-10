;; Peter +10, Paul -20, Mary -/2

;; 1. 45
;; Peter -> Paul -> Mary
;; 100 +10 -20 -/2 = 45
;; or Paul -> Peter -> Mary
;; 100 -20 -> +10 -> -/2 = 45 

;; 2. 35
;; Peter -> Mary -> Paul
;; 100 +10 -> -/2 -> -20 = 35

;; 3. 50
;; Paul -> Mary -> Peter
;; 100 -20 -> -/2 -> +10 = 50

;; 4. 40
;; Mary -> Peter -> Paul
;; 100 -/2 -> +10 -> -20 = 40
;; or Mary -> Paul -> Peter
;; 100 -/2 -> -20 -> +10 = 40

;; There are a lot of possibilities of incorrect answer here. I will only
;; show few of them here.
;;
;; Example of incorrect result $110
;; 
;;     Peter                     Paul                    Bank                  Mary
;;
;;       +------------------------+----------------------$100-------------------+
;;       |                        |                                             |
;;       |                        |                                             v
;;       |                        |                                     (access bal: $100)
;;       |                        |                                             |
;;       |                        |                                             v
;;       |                        v                                     (access bal: $100)
;;       |                 (access bal: $100)                                   |
;;       v                        |                                             v
;;  (access bal: $100)            v                                    (new val: 100/2=50)
;;       |               (new val: 100-20=80)                                   |
;;       v                        |                                             v
;; (new val: 100+10=110)          v                                      (set! bal to 50)
;;       |                 (set! bal to 80)                                     |
;;       v                        |                      $50--------------------+
;; (set! bal to 110)              |                     
;;       |                        +----------------------$80
;;       |
;;       +----------------------------------------------$110
;;       
;;       
;; Example of incorrect result $80
;; 
;;     Paul                     Peter                    Bank                  Mary
;;
;;       +------------------------+----------------------$100-------------------+
;;       |                        |                                             |
;;       |                        |                                             v
;;       |                        |                                     (access bal: $100)
;;       |                        |                                             |
;;       |                        |                                             v
;;       |                        v                                     (access bal: $100)
;;       |                 (access bal: $100)                                   |
;;       v                        |                                             v
;;  (access bal: $100)            v                                    (new val: 100/2=50)
;;       |               (new val: 100+10=110)                                  |
;;       v                        |                                             v
;; (new val: 100-20=80)           v                                      (set! bal to 50)
;;       |                 (set! bal to 110)                                    |
;;       v                        |                      $50--------------------+
;; (set! bal to 80)               |                     
;;       |                        +---------------------$110
;;       |
;;       +-----------------------------------------------$80
;;       
;;       
;; Example of incorrect result $50
;; we already seen $50 as correct result, but let's look at the total amount of money
;; that we have (simplified) to see the isssue. So, initially we have $100 in the bank
;; and let's say Peter has $10, so in total it's $110. Now, looking at the diagram below
;; we see that in the end Peter will have $0, Paul - $20, Mary - $50 and $50 in the bank.
;; So, it's $120 in total which is INCORRECT (initially total was $110)
;; 
;;     Mary                     Peter                    Bank                  Paul
;;
;;       +------------------------+----------------------$100-------------------+
;;       |                        |                                             |
;;       |                        |                                             v
;; (access bal: $100)             v                                     (access bal: $100)
;;       |                 (access bal: $100)                                   |
;;       v                        |                                             v
;; (access bal: $100)             v                                    (new val: 100-20=80)
;;       |               (new val: 100+10=110)                                  |
;;       v                        |                                             v
;; (new val: 100/2=50)            v                                      (set! bal to 80)
;;       |                 (set! bal to 110)                                    |
;;       v                        |                      $80--------------------+
;; (set! bal to 50)               |                     
;;       |                        +---------------------$110
;;       |
;;       +-----------------------------------------------$50
