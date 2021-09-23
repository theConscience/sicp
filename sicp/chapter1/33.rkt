#lang sicp

(#%require rackunit)

; TASK:
;
; Обобщенное накопление
; Можно получить еще более общую версию accumulate (упражнение 1.32 ), если
; ввести понятие фильтра (filter) на комбинируемые термы.То есть комбинировать
; только те термы, порожденные из значений диапазона, которые удовлетворяют
; указанному условию. Получающаяся абстракция filtered-accumulate получает те
; же аргументы, что и accumulate , плюс дополнительный одноаргументный
; предикат, который определяет фильтр. Запишите filtered-accumulate ввиде
; процедуры. Покажите, как с помощью filtered-accumulate выразить следующее:
;
; а. сумму квадратов простых чисел в интервале от a до b (в предположении, что
; процедура prime? уже написана);
;
; б. произведение всех положительных целых чисел меньше n , которые просты по
; отношению к n (то есть всех таких положительных целых чисел i < n , что НОД
; (i, n) = 1 ).


; SOLUTION:

(define (filtered-accumulate combiner null-value term a next b filter?)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (if (filter? a)
                           (combiner (term a) result)
                           result))))
  (iter a null-value))

; (define (filtered-accumulate combiner null-value term a next b filter?)
;   (if (> a b)
;       null-value
;       (if (filter? a)
;           (combiner (term a)
;                     (filtered-accumulate combiner null-value term (next a) next b filter?))
;           (filtered-accumulate combiner null-value term (next a) next b filter?))))

(define (sum a b) (filtered-accumulate + 0 identity a inc b identity))
(define (prod a b) (filtered-accumulate * 1 identity a inc b identity))

(define (prime-square-sum a b) (filtered-accumulate + 0 square a inc b prime?))

(define (b-prime-product b)
  (define (is-prime-for-b x) (= (gcd b x) 1))
  (filtered-accumulate * 1 identity 1 inc b is-prime-for-b))


; HELPERS:

(define (smallest-divisor n)
  (define (find-divisor test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor (+ test-divisor 1)))))
  (find-divisor 2))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

(define (inc n) (+ n 1))

(define (square x) (* x x))

(define (identity x) x)


; TESTS:

(check-equal? (filtered-accumulate * 1 square 1 inc 3 odd?) 9)
(check-equal? (filtered-accumulate * 1 identity 3 inc 5 odd?) 15)
(check-equal? (filtered-accumulate + 0 identity 1 inc 10 odd?) 25)
(check-equal? (sum 1 4) 10)
(check-equal? (prod 1 4) 24)
(check-equal? (prime-square-sum 1 5) 39)
(check-equal? (b-prime-product 2) 1)
(check-equal? (b-prime-product 3) 2)
(check-equal? (b-prime-product 4) 3)
(check-equal? (b-prime-product 5) 24)
(check-equal? (b-prime-product 6) 5)
(check-equal? (b-prime-product 7) 720)
