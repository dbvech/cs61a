;; Louis is wrong, Ben's procedure will work well concurrently. The essential
;; difference here is that for exchange problem we need to READ both values
;; (acc1 balance and acc2 balance) to calculate difference, and only after that
;; we use that diff to withdraw and deposit, so all those steps are SINGLE 
;; crtical section. But in example of translfer problem we have two regular
;; operations - withdraw THEN deposit. We already know the amount, so we don't
;; need to read both values (balances). Withdraw procedure doesn't read 
;; balance of other account, it reads balance of it's account, then changes it.
;; Then deposit happening, which, in turn, also doesn't need to read value 
;; of first account. 
