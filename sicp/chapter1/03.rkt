#lang sicp

(#%require rackunit)

(define (solution x y z)
  (cond
    ((and (>= x y) (>= y z)) (+ (* x x) (* y y)))
    ((and (>= x y) (< y z)) (+ (* x x) (* z z)))
    ((and (>= y z) (>= z x)) (+ (* y y) (* z z)))
    ((and (>= y z) (< z x)) (+ (* y y) (* x x)))
    ((and (>= z x) (>= x y)) (+ (* z z) (* x x)))
    ((and (>= z x) (< x y)) (+ (* z z) (* y y)))
  ))

(check-equal? (solution 1 2 3) 13)
(check-equal? (solution -1 4 6) 52)
(check-equal? (solution -1 -10 2) 5)
