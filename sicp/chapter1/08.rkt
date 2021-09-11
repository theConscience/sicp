#lang sicp


; TASK:
; Make procedure for cube root extraction:


; SOLUTION:

(define (square x) (* x x))

(define (cube x) (* x x x))

(define (abs x) (if (< x 0) (- x) x))

(define (average x y) (/ (+ x y) 2))


(define (cube-root x)

  (define (improve guess)
    (/ (+ (/ x (square guess)) (* 2 guess)) 3))

  (define (good-enought? guess)
    (< (abs (- (cube guess) x)) 0.001))

  (define (cube-iter guess)
    (if (good-enought? guess)
        guess
        (cube-iter (improve guess)))) #| recursion! |#

  (cube-iter 1.0))
