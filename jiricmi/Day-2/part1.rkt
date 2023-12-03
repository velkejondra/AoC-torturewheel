#lang racket


(define (get-game line)
  (string-split line ";"))

(define (get-elem line)
  (string-split line ","))


(define (res-game? game)
  (and (and (el-pass? (get-elem game) "red" 12) (el-pass? (get-elem game) "green" 13)) (el-pass? (get-elem game) "blue" 14)))


(define (el-pass? game color mincnt [count 0])
  (cond
    [(empty? game) (>= mincnt count)]
    [else (el-pass? (cdr game) color mincnt (if (string=? (car(cdr(string-split (car game) " "))) color) (+ count (string->number(car(string-split (car game) " ")))) count))])) 
  

(define (each-game games [res #t])
  (cond
    [(and (empty? games) (equal? res #f)) #f]
    [(empty? games) #t]
    [else (each-game (cdr games) (if (equal? res #t) (res-game? (car games)) #f))]))

(define (is-playable? line)
  (cond
    [(string? line) (each-game (get-game line))]
    [else (is-playable? (car line))]))


(define (get-num-game line)
  (string->number (car(cdr(string-split (car (string-split line ":")) " ")))))


(define (parse-comp line)
  (cond
    [(is-playable? (cdr(string-split line ":"))) (get-num-game line)]
    [else 0]))



(define (parse-line lines [sumo 0])
  (cond
    [(empty? lines) sumo]
    [else (parse-line (cdr lines) (+ sumo (parse-comp (car lines))))]))


(define (part1 lines)
  (parse-line(string-split lines "\n")))
