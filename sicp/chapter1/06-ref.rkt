#lang sicp

; refactoring of sqrt function with incapsulation of locally-defined functions

(define (sqrt x)

  (define (square x) (* x x))

  (define (abs x) (if (< x 0) (- x) x))

  (define (average x y) (/ (+ x y) 2))

  (define (improve guess x)
    (average guess (/ x guess)))

  (define (good-enought? guess x)
    (< (abs (- (square guess) x)) 0.001))

  (define (sqrt-iter guess x)
    (if (good-enought? guess x)
        guess
        (sqrt-iter (improve guess x) x))) #| recursion! |#

  (sqrt-iter 1.0 x))
