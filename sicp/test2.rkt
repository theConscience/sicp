#lang racket

(+
  (* 3
     (+
       (* 2 5)
       (+ 3 5)))
  (+
    (- 10 7) 6)
  )


(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))
(abs 2)


(define (abs2 x)
  (if (< x 0) (- x) x))
(abs2 -19)


(define (>= x y)
  (or (> x y)
      (= x y)
      ))
(>= 9 9)

