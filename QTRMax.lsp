;
;
;     Program written by Robert Livingston, 2018-08-08
;
;     C:QTRMAX is a utility for rotating a QuickTurn Vehicle it's maximum inswing
;
;
(defun C:QTRMAX (/ ANG ANG1 D ENT P P1 P2 PC ORTHOMODE OSMODE R R2)
 (setq OSMODE (getvar "OSMODE"))
 (setq ORTHOMODE (getvar "ORTHOMODE"))
 (setq ENT (entsel "\nSelect vehicle : "))
 (setq P1 (getpoint "\nFront wheel point : "))
 (setq P1 (list (car P1) (cadr P1)))
 (setq P2 (getpoint "\nRear wheel point : "))
 (setq P2 (list (car P2) (cadr P2)))
 (setq PC (getpoint "\nCenter point : "))
 (setq PC (list (car PC) (cadr PC)))
 (setq ANG (angle PC P1))
 (setq R (distance PC P1))
 (setq D (distance P1 P2))
 (setq R2 (sqrt (- (* R R) (* D D))))
 (setq ANG1 (atan (/ D R2)))
 (initget "Left Right")
 (if (= "Right" (setq LR (getkword "\n<Left> or Right : ")))
  (setq P (list (+ (car PC) (* R2 (cos (+ ANG ANG1))))
                (+ (cadr PC) (* R2 (sin (+ ANG ANG1))))
          )
  )
  (setq P (list (+ (car PC) (* R2 (cos (- ANG ANG1))))
                (+ (cadr PC) (* R2 (sin (- ANG ANG1))))
          )
  )
 )
 (setvar "OSMODE" 0)
 (setvar "ORTHOMODE" 0)
 (command-s "._ROTATE" ENT "" P1 "R" P1 P2 P)
 (setvar "OSMODE" OSMODE)
 (setvar "ORTHOMODE" ORTHOMODE)
 T
)