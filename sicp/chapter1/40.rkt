#lang sicp

(#%require rackunit)

; TASK:
;
; Вычисление нулей
; Определите процедуру cubic , которую можно было бы использовать совместно
; с процедурой newtons-method в выражениях вида
;
; (newtons-method (cubic a b c) 1)

; для приближенного вычисления нулей кубических уравнений x³ + ax² + bx + c .


; SOLUTION:

(define (cubic a b c)
  (lambda (x) (+ (cube x) (* a (square x)) (* b x) c)))


; HELPERS
(define (cube x) (* x x x))
(define (square x) (* x x))

(define tolerance 0.00001)

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
          (< (abs (- v1 v2)) tolerance))
      (define (try guess)
            (let ((next (f guess)))
                    (if (close-enough? guess next)
                                next
                                          (try next))))
        (try first-guess))


(define (deriv g)
    (lambda (x)
          (/ (- (g (+ x tolerance)) (g x))
                    tolerance)))

(define (newton-transform g)
    (lambda (x)
          (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
    (fixed-point (newton-transform g) guess))


; TESTS:

(check-equal? (round (newtons-method (cubic 0 0 0) 1)) 0.0)
(check-equal? (round (newtons-method (cubic 0 0 (- 27)) 10)) 3.0)
(check-equal? (round (newtons-method (cubic 0 0 (- 81)) 10)) 4.0)
(check-equal? (round (newtons-method (cubic 2 8 (- 32)) 10)) 2.0)

