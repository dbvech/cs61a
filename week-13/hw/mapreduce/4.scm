;; The Sieve of Eratosthenes is a sequential algorithm that relies on previously 
;; identified primes.
;;
;; However, we can still use MapReduce (without the benefits of parallelization) 
;; to filter prime numbers. The mapper procedure generates intermediate key-value 
;; pairs with a static key, such that all pairs are directed to a single reducer 
;; instance. The value will be the number itself, making this more of an “identity” 
;; mapper. Since MapReduce filters by keys, the reducer will receive all numbers 
;; sorted in ascending order. The current value in the reducer represents the 
;; current number, while the accumulated value is a list of previous primes. 
;; We check if the current number is divisible by any number in the primes list. 
;; If it is, the number is ignored; if not, it is added to the list of primes. 
;; As mentioned earlier, this approach provides ZERO benefits (and is even worse) 
;; compared to running the algorithm in a single instance without MapReduce.
;;
;; An alternative approach is to use a predefined list of primes such as 
;; (2, 3, 5, 7, 11). The mapper checks if the current number is divisible by any 
;; number from this list. If not, it sends the number to the reducer with the 
;; same key, ensuring all numbers are sorted. The result will be a list such as 
;; (13, 17, 19, 23, 29, 31 …), but this list may include numbers divisible by 
;; primes not in the predefined list (e.g., 121, which is divisible by 11, and 
;; therefore not prime). To address this, we need to run MapReduce again. This 
;; time, we use the results from the previous step (excluding the first number) 
;; as the data, and the first number from the result list (13) as the new prime. 
;; We then filter out any numbers divisible by 13, add 13 to the initial primes 
;; list (2, 3, 5, 7, 11, 13), and repeat the MapReduce process. Now we use 17 as 
;; the next prime and filter the remaining numbers accordingly. This process 
;; continues until no numbers remain to test.
;;
;; While this approach is more complex, the benefits of parallelization here 
;; remain questionable.
