;
;
;   Program written by Robert Livingston, 2016-05-16
;
;   QT:COPY copies a vehicle at posicion 'C' to a temporary block
;
;
(defun QT:COPY (/ NODE)
 (foreach NODE QTVLIST
  (progn
   (QT:MAKETEMPBLOCK (last NODE))
  )
 )
)
