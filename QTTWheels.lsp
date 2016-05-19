;
;
;   Program written by Robert Livingston, 2016-05-16
;
;   QT:TWHEELS Traces the position of the wheels
;              Note:  Command not implemented
;
;
(defun QT:TWHEELS (/ C CECOLOR COLOR DX DY NODE P1 P2 TRACEWHEEL)
 (setq CECOLOR (getvar "CECOLOR"))
 (defun TRACEWHEEL (/ N)
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
 (setq COLOR (getint "\nEnter colour for trace (0-256, 0=ByBlock, 256=ByLayer) <0> : "))
 (if (= nil COLOR) (setq COLOR 0))
 (if (or (< COLOR 0) (> COLOR 256)) (setq COLOR 0))
 (setvar "CECOLOR" (itoa COLOR))
 (setq C 0)
 (while (< C (length QTVLIST))
  (setq NODE (nth C QTVLIST))
  (GETD (car NODE))
  ; Front Left
  (if (/= nil WF)
   (progn
    (setq DX DG)
    (setq DY (* -0.5 WF))
    (TRACEWHEEL)
   )
  )
  ; Front Right
  (if (/= nil WF)
   (progn
    (setq DX DG)
    (setq DY (* 0.5 WF))
    (TRACEWHEEL)
   )
  )
  ; Rear Left
  (if (/= nil WR)
   (progn
    (setq DX D)
    (setq DY (* -0.5 WR))
    (TRACEWHEEL)
   )
  )
  ; Rear Right
  (if (/= nil WR)
   (progn
    (setq DX D)
    (setq DY (* 0.5 WR))
    (TRACEWHEEL)
   )
  )
  (setq C (+ C 1))
 )
 (setvar "CECOLOR" CECOLOR)
)
