#lang sicp

(#%require rackunit)

; TASK:
;
; Представление пар с помощью чисел и арифметических операций
;
; Покажите, что можно представлять пары неотрицательных целых чисел, используя
; только числа и арифметические операции, если представлять пару a и b как
; произведение 2^a * 3^b .
; Дайте соответствующие определения процедур cons , car и cdr .


; SOLUTION:

(define (cons x y)
  (* (exp 2 x) (exp 3 y)))

(define (car z)
  (define (car-iter n counter)
    (if (and (>= n 2) (divides? n 2))
      (car-iter (/ n 2) (+ counter 1))
      counter))
  (car-iter z 0))

(define (cdr z)
  (define (cdr-iter n counter)
    (if (and (>= n 3) (divides? n 3))
      (cdr-iter (/ n 3) (+ counter 1))
      counter))
  (cdr-iter z 0))

#| (define (cdr z) |#
#|   (z (lambda (p q) q))) |#


; HELPERS:

(define (exp base degree)
  (define (exp-iter b n a)
    (cond
      ((< n 0) (/ 1 (exp-iter b (- n) a)))
      ((= n 0) (if (= a 1) 1 a))
      ((even? n) (exp-iter (* b b) (/ n 2) a))
      (else (exp-iter b (- n 1) (* a b)))))

  (exp-iter base degree 1))

(define (divides? a b)
  (= (remainder a b) 0))

(define (>= a b) (not (< a b)))


; TESTS:

(define x (cons 2 3))
(define y (cons 1 5))
(define z (cons 11 21))
(define a (cons 1 1))
(define b (cons 0 0))

(check-equal? (car x) 2)
(check-equal? (cdr x) 3)
(check-equal? (car y) 1)
(check-equal? (cdr y) 5)
(check-equal? (car z) 11)
(check-equal? (cdr z) 21)
(check-equal? (car a) 1)
(check-equal? (cdr a) 1)
(check-equal? (car b) 0)
(check-equal? (cdr b) 0)
