#lang sicp

(#%require rackunit)

; TASK:
;
(define (gcd a b)
  (if (= b 0)
  a
  (gcd b (remainder a b))))
;
; Процесс, порождаемый процедурой, разумеется, зависит от того, по каким
; правилам работает интерпретатор. В качестве примера рассмотрим итеративную
; процедуру gcd , приведенную выше. Предположим, что мы вычисляем эту процедуру
; с помощью нормального порядка, описанного в разделе 1.1.5. (Правило
; нормального порядка вычислений для if описано в упражнении 1.5 .) Используя
; подстановочную модель для нормального порядка, проиллюстрируйте процесс,
; порождаемый при вычислении (gcd 206 40) и укажите, какие операции вычисления
; остатка действительно выполняются. Сколько операций remainder выполняется на
; самом деле при вычислении (gcd 206 40) в нормальном порядке? При вычислении
; в аппликативном порядке?
;


; SOLUTION:


(gcd 206 40)

;
; Аппликативный порядок вычислений:
; (gcd 40 (remainder 206 40)) ; > 0
; (gcd 40 6)                  ; > 1
; (gcd 6 (remainder 40 6))    ; > 1
; (gcd 6 4)                   ; > 2
; (gcd 4 (remainder 6 4))     ; > 2
; (gcd 4 2)                   ; > 3
; (gcd 2 (remainder 4 2))     ; > 3
; (gcd 2 0)                   ; > 4
; 2


; Нормальный порядок вычислений:
; (gcd 40 (remainder 206 40)) ; = 0

; (if (= 40 0)
;   206
;   (gcd 40 (remainder 206 40)))  ; = 0

; (if (= (remainder 206 40) 0)    ; = 0
;   40
;   (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))

; (if (= 6 0)                     ; = 1
;   40
;   (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))
;
; (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))
;
; (if (= (remainder 40 (remainder 206 40)) 0)  ; = 1
;   (remainder 206 40)
;   (gcd
;     (remainder 40 (remainder 206 40))
;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
;
; (if (= (remainder 40 6) 0)  ; = 2
;   (remainder 206 40)
;   (gcd
;     (remainder 40 (remainder 206 40))
;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
;
; (if (= 4 0)                 ; = 3
;   (remainder 206 40)
;   (gcd
;     (remainder 40 (remainder 206 40))
;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
;
; (gcd
;   (remainder 40 (remainder 206 40))
;   (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
;
; (if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0)
;   (remainder 40 (remainder 206 40))
;   (gcd
;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;     (remainder
;       (remainder 40 (remainder 206 40))
;       (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
;
; (if (= (remainder (remainder 206 40) (remainder 40 6)) 0)  ; = 4
;   (remainder 40 (remainder 206 40))
;   (gcd
;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;     (remainder
;       (remainder 40 (remainder 206 40))
;       (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
;
; (if (= (remainder (remainder 206 40) 4) 0)  ; = 5
;   (remainder 40 (remainder 206 40))
;   (gcd
;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;     (remainder
;       (remainder 40 (remainder 206 40))
;       (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
;
; (if (= (remainder 6 4) 0)  ; = 6
;   (remainder 40 (remainder 206 40))
;   (gcd
;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;     (remainder
;       (remainder 40 (remainder 206 40))
;       (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
;
; (if (= 2 0)  ; = 7
;   (remainder 40 (remainder 206 40))
;   (gcd
;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;     (remainder
;       (remainder 40 (remainder 206 40))
;       (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
;
; (gcd
;   (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;   (remainder
;     (remainder 40 (remainder 206 40))
;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
;
; (if (= (remainder   ; = 7
;   (remainder 40 (remainder 206 40))
;   (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0)
;
;   (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) ; СЛЕДСТВИЕ
;
;   (remainder                                                    ; АЛЬТЕРНАТИВА
;     (remainder 40 (remainder 206 40))
;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
;
; ...  считаем if:
;
; (remainder   ; = 7
;   (remainder 40 (remainder 206 40))
;   (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;
; (remainder   ; = 7 + 3
;   (remainder 40 6)
;   (remainder 6 (remainder 40 6)))
;
; (remainder   ; = 7 + 3 + 2
;   4
;   (remainder 6 4))
;
; (remainder   ; = 7 + 3 + 2 + 1
;   4
;   2)
;
; (remainder 4 2)  ; = 13
; 0                ; = 14
;
; получаем 0, наконец попадаем в ветку следствия X:
;
; (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) ; = 13
; (remainder 6 (remainder 40 6)) ; = 14 + 2
; (remainder 6 4) ; = 14 + 2 + 1
; 2               ; = 14 + 2 + 1 + 1
; 2               ; 18

; Ответы:
; - при аппликативном порядке 4 вызова REMAINDER
; - при нормальном порядке 18 вызовов REMAINDER
