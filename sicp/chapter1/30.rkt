#lang sicp

(#%require rackunit)

; TASK:
; Итерация
; Процедура sum порождает линейную рекурсию. Ее можно переписать так, чтобы
; суммирование выполнялось итеративно. Покажите, как сделать это, заполнив
; пропущенные выражения в следующем определении:
;
; (define (sum term a next b)
;   (define (iter a result)
;       (if <??>
;           <??>
;             (iter <??> <??>)))
;   (iter <??> <??>))

; Рекурсивная версия:
;
; (define (rec-sum term a next b)
;   (if (> a b)
;     0
;     (+ (term a)
;        (rec-sum term (next a) next b))))



; SOLUTION:

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

#| (define (sum term a next b) |#
#|    (if (> a b) |#
#|      0 |#
#|      (+ (term a) |#
#|         (sum term (next a) next b)))) |#


; TESTS:

(define (inc n) (+ n 1))

(define (cube x) (* x x x))

(define (identity x) x)

(check-equal? (sum cube 0 inc 2) 9)
(check-equal? (sum cube 1 inc 10) 3025)
(check-equal? (sum identity 1 inc 10) 55)
