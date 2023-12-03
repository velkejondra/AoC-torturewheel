#lang racket


(define (get-game line)
  (string-split line "; "))

(define (get-elem line)
  (string-split line ", "))

(define (get-vetsi one two)
  (list (max (list-ref one 0) (list-ref two 0))
            (max (list-ref one 1) (list-ref two 1))
            (max (list-ref one 2) (list-ref two 2))))

(define (get-e game)
  (list (count-elem game "red") (count-elem game "green") (count-elem game "blue")))

(define (count-elem game color [res 0])
  (cond
    [(empty? game) res]
    [else (count-elem (cdr game) color (if (string=? (car(cdr(string-split (car game) " "))) color) (+ res (string->number(car(string-split (car game) " ")))) res))])) 


(define (parsing-games games [res '(0 0 0)])
  (cond
    [(empty? games) res]
    [else (parsing-games (cdr games) (get-vetsi res (get-e (get-elem(car games)))))]))

(define (get-mult line)
  (apply * (parsing-games (get-game(car(cdr(string-split line ": ")))))))


(define (parse-line lines [sumo 0])
  (cond
    [(empty? lines) sumo]
    [else (parse-line (cdr lines) (+ sumo (get-mult (car lines))))]))
    


(define (part1 lines)
  (parse-line(string-split lines "\n")))
