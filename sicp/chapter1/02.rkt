#lang sicp

(#%require rackunit)

;(/
;  (+ 5 4 (- 2 (- 3 + 6 ((/ 4 5))))
;    )* 3 (- 6 2( )- 2 7()
;    ))


(define solution
  (/ (+ 5
        4
        (- 2
           (- 3
              (+ 6
                 (/ 4
                    (dec
                     (inc
                      5)))))))
     (* 3
        (- 6
           2)
        (- 2
           7))))

(check-equal? solution -37/150)
