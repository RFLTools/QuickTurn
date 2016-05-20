;
;
;   Program written by Robert Livingston, 2016-05-16
;
;   QT:NEWANG Calculates the new angle after a linear movement
;
;
(defun QT:NEWANG (ANG P1 P2 D D0 / ANG2 ANG3 SIGN TOL)
 (setq TOL 0.0000001)
 (setq ANG2 (- ANG (angle P1 P2)))
 (while (< ANG2 0.0)
  (setq ANG2 (+ ANG2 (* 2.0 pi)))
 )
 (while (>= ANG2 (* 2.0 pi))
  (setq ANG2 (- ANG2 (* 2.0 pi)))
 )
 (setq SIGN 1.0)
 (if (> ANG2 pi)
  (progn
   (setq SIGN -1.0)
   (setq ANG2 (- (* 2.0 pi) ANG2))
  )
 )
 (if (< ANG2 TOL)
  (setq ANG2 0.0)
  (setq ANG2 (* 2.0
                (atan (exp (- (log (TAN (/ ANG2 2.0)))
                              (/ (distance P1 P2) (- D D0))
                           )
                      )
                )
             )
  )
 )
 (setq ANG2 (+ (angle P1 P2) (* SIGN ANG2)))
 (while (< ANG2 0.0)
  (setq ANG2 (+ ANG2 (* 2.0 pi)))
 )
 (while (>= ANG2 (* 2.0 pi))
  (setq ANG2 (- ANG2 (* 2.0 pi)))
 )
 (eval ANG2)
)
