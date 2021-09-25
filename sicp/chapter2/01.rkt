#lang sicp

(#%require rackunit)

; TASK:
;
; Модификация make-rat
;
; Определите улучшенную версию make-rat , которая принимала бы как
; положительные, так и отрицательные аргументы. Make-rat должна нормализовывать
; знак так, чтобы в случае, если рациональное число положительно, то и его
; числитель, и знаменатель были бы положительны, а если оно отрицательно, то
; чтобы только его числитель был отрицателен.


; SOLUTION:

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (make-rat a b)
  (let ((g (gcd a b)))
       (cond ((and (not (< a 0)) (< b 0))
              (cons (/ (- a) g) (/ (- b) g)))
             ((and (< a 0) (< b 0))
              (cons (/ (- a) g) (/ (- b) g)))
             (else (cons (/ a g) (/ b g))))))

#| (define (make-rat a b) |#
#|   (let ((g ((if (< b 0) - +) (gcd a b)))) |#
#|              (cons (/ a g) (/ b g)))) |#

(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (add-rat x y)
  (make-rat
    (+ (* (numer x) (denom y))
       (* (numer y) (denom x)))
    (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat
    (- (* (numer x) (denom y))
       (* (numer y) (denom x)))
    (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat
    (* (numer x) (numer y))
    (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat
    (* (numer x) (denom y))
    (* (numer y) (denom x))))

(define (is-equal-rat x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))


; HELPERS:

(define one-half (make-rat 1 2))
(define -one-half (make-rat -1 2))
(define one-third (make-rat 1 3))
(define -one-third (make-rat -1 3))
(define one-fourth (make-rat -1 4))

(define (extract-rat x)
  (/ (numer x) (denom x)))

(define inc (lambda (x) (+ x 1)))
(define square (lambda (x) (* x x)))



; TESTS:

(check-equal? (extract-rat (make-rat 1 -2)) -1/2)
(check-equal? (extract-rat (add-rat one-half one-third)) 5/6)
(check-equal? (extract-rat (mul-rat one-half -one-third)) -1/6)
