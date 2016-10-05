
;
;
;     Program written by Robert Livingston, 2015-11-13
;
;     QT:GETTURNANG Dispalys the current wheel turn angle
;
;
(defun QT:GETTURNANG (C PLIST LOCKANG / ANG DIRECTION P0 P1 P2 PC R)
 (if (= C CMAX)
  (eval "*undefined*")
  (progn
   (if (= C 0)
    (setq P0 nil P1 (nth C PLIST) P2 (nth (+ C 1) PLIST))
    (if (= C CMAX)
     (setq P0 (nth (- C 1) PLIST) P1 (nth C PLIST) P2 nil)
     (progn
      (setq P0 (nth (- C 1) PLIST) P1 (nth C PLIST) P2 (nth (+ C 1) PLIST))
      (setq PC (QT:CIRCLE3P P0 P1 P2))
      (if (= PC nil)
       (setq P0 nil)
       (progn
        (setq R (cadr PC))
        (setq PC (car PC))
        (setq ANG (angle P1 PC))
        (if (> (sin (- (angle P2 PC) (angle P1 PC))) 0.0)
         (setq ANG (- ANG (/ pi 2.0)))
         (setq ANG (+ ANG (/ pi 2.0)))
        )
        (setq P2 (list (+ (car P1) (* R (cos ANG)))
                       (+ (cadr P1) (* R (sin ANG)))))
       )
      )
     )
    )
   )	
   (setq ANG (nth C (cadr (car QTVLIST))))
   (setq ANG (- ANG (angle P2 P1)))
   (while (< ANG 0.0)
    (setq ANG (+ ANG (* 2.0 pi)))
   )
   (while (>= ANG (* 2.0 pi))
    (setq ANG (- ANG (* 2.0 pi)))
   )
   (setq DIRECTION "Right")
   (if (> ANG pi)
    (progn
     (setq DIRECTION "Left")
     (setq ANG (- (* 2.0 pi) ANG))
    )
   )
   (if (and (= QT:LOCKANGWARNING nil) (/= LOCKANG 0.0))
    (if (> ANG (* LOCKANG (/ pi 180.0)))
     (progn
      (setq QT:LOCKANGWARNING T)
      (alert "Warning - Lock angle exceeded!")
     )
    )
   )
   (if (> ANG (* LOCKANG (/ pi 180.0)))
    (foreach NODE QTVLIST (redraw (last NODE) 3))
    (foreach NODE QTVLIST (redraw (last NODE) 1))
   )
   (strcat DIRECTION " " (angtos ANG 1 2))
  )
 )
)