;
;
;   Program written by Robert Livingston, 2016-05-16
;
;   QT:TPATH Traces a user supplied position
;
;
(defun QT:TPATH (/ ANG DX DY N NODE P1 P2 REP)
 (setq N (getint (strcat "\nWhich vehicle (1 to " (itoa (length QTVLIST)) ", <return> to cancel) : ")))
 (if (/= nil N)
  (if (and (> N 0) (<= N (length QTVLIST)))
   (progn
    (setq NODE (nth (- N 1) QTVLIST))
    (setq ANG (nth C (cadr NODE)))
    (setq P2 (getpoint (setq P1 (nth C (caddr NODE))) "\nPick trace point : "))
    (if (/= P2 nil)
     (progn
      (setq DX (* (distance P1 P2) (cos (- (angle P1 P2) ANG))))
      (setq DY (* (distance P1 P2) (sin (- (angle P1 P2) ANG))))
      (setq N 0)
      (setvar "OSMODE" 0)
      (command "._PLINE")
      (while (< N CMAX)
       (setq ANG (nth N (cadr NODE)))
       (setq P1 (nth N (caddr NODE)))
       (setq P2 (list (+ (car P1)
                         (* DX (cos ANG))
                         (* -1.0 DY (sin ANG))
                      )
                      (+ (cadr P1)
                         (* DX (sin ANG))
                         (* DY (cos ANG))
                      )
                )
       )
       (command P2)
       (setq N (+ N 1))
      )
      (command "")
      (setvar "OSMODE" OSMODE)
     )
    )
   )
  )
 )
)
