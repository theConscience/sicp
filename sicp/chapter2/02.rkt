#lang sicp

(#%require rackunit)

; TASK:
;
; Представление отрезков на плоскости
;
; Рассмотрим задачу представления отрезков прямой на плоскости.
; Каждый отрезок представляется как пара точек: начало и конец.
; Определите конструктор make-segment и селекторы start-segment и end-segment,
; которые определяют представление отрезков в терминах точек.
; Далее, точку можно представить как пару чисел: координата x и координата y.
; Соответственно, напишите конструктор make-point и селекторы x-point и y-point,
; которые определяют такое представление.
; Наконец, используя свои селекторы и конструктор, напишите процедуру midpoint-segment,
; которая принимает отрезок в качестве аргумента и возвращает его середину
; (точку, координаты которой являются средним координат концов отрезка).
; Чтобы опробовать эти процедуры, Вам потребуется способ печатать координаты точек:

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))


; SOLUTION:

;Segments usage procedures
(define (midpoint-segment s)
  (let ((start-p (start-segment s))
        (end-p (end-segment s)))
       (make-point
         (/ (+ (x-point start-p) (x-point end-p)) 2)
         (/ (+ (y-point start-p) (y-point end-p)) 2))))

; Segments
(define (make-segment start-p end-p) (cons start-p end-p))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

; Points
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))


; HELPERS:

(define inc (lambda (x) (+ x 1)))
(define square (lambda (x) (* x x)))


; TESTS:

(define p1 (make-point 2 3))
(define p2 (make-point 4 5))

(define s (make-segment p1 p2))

(check-equal? (make-segment p1 p2) '((2 . 3) 4 . 5))
(check-equal? (midpoint-segment s) '(3 . 4))
(check-equal? (start-segment s) p1)
(check-equal? (end-segment s) p2)
(check-equal? (x-point p1) 2)
(check-equal? (y-point p2) 5)
