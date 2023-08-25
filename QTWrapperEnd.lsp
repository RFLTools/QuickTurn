;
;
;   Program written by Robert Livingston, 2016-05-16
;
;   C:QUICKTURN main routine
;
;   QTWrapperEnd.lsp is the footer wrapper for C:QUICKTURN
;
;
 (setq ENT (entsel "\nSelect polyline path (<return> to insert vehicle) : "))
 (if (= nil ENT)
  (C:QTMAKE)
  (progn
   (setq P (cadr ENT))
   (setq ENT (car ENT))
   (setq ENTFIRST (car (entsel "\nSelect vehicle : ")))
   (setq D0 nil DG nil D nil DH nil LA nil LB nil)
   (setq TMP (QT:GETD ENTFIRST))
   (setq D0 (nth 0 TMP)
         DG (nth 1 TMP)
         D (nth 2 TMP)
         DH (nth 3 TMP)
         FIRSTLOCKANG (nth 4 TMP)
         LB (nth 5 TMP)
         LA (nth 6 TMP)
         WF (nth 7 TMP)
         WR (nth 8 TMP)
   )
   (setq STEP (/ (- D D0) 10.0))
   (setq PLIST (QT:GETPLIST P STEP ENT))
   (if (= nil PLIST)
    (princ "\nProblem getting vehicle path...")
    (progn
     (setq CMAX (- (length PLIST) 1))
     (QT:SETPATH PLIST ENTFIRST)
     (if (= nil LOCKANG) (setq LOCKANG 0.0))
     (setq REP "Forward")
     (setq C 0)
     (while (/= "Exit" REP)
      (QT:PLACE C)
      (initget "Forward Back Move Copy enVelope bOundary Step Trace Wheels Exit eXit")
      (QT:SETWHEELANG C QTVLIST PLIST)
      (setq REP2 (getkword (strcat "\nSA:" (QT:GETTURNANG C PLIST FIRSTLOCKANG) " - Forward/Back/Move/Copy/enVelope/bOundary/Step/Trace/eXit <" REP "> : ")))
      (if (= REP2 nil) (setq REP2 REP))
      (if (or (= REP2 "Forward") (= REP2 "Back")) (setq REP REP2))
      (cond ((= REP2 "Forward")
             (setq C (+ C 1))
            )
            ((= REP2 "Back")
             (setq C (- C 1))
            )
            ((= REP2 "Move")
             (QT:MOVEVEHICLE PLIST)
            )
            ((= REP2 "Copy")
             (QT:COPY)
            )
            ((= REP2 "Step")
             (setq C (+ C (getint "\nEnter steps (+ve = forward, -ve = back) : ")))
            )
            ((= REP2 "Trace")
             (QT:TPATH)
            )
;            ((= REP2 "Wheels")
;             (QT:TWHEELS)
;            )
            ((= REP2 "enVelope")
             (QT:DRAWENVELOPE)
            )
            ((= REP2 "bOundary")
             (QT:DRAWENVELOPE2)
            )
            ((or (= REP2 "Exit") (= REP2 "eXit"))
             (progn
              (foreach NODE QTVLIST (redraw (car NODE) 1))
              (foreach NODE QTVLIST (entdel (last NODE)))
              (setq REP "Exit")
             )
            )
      )
      (if (> C CMAX) (setq C CMAX))
      (if (< C 0) (setq C 0))
     )
    )
   )
  )
 )
 (command-s "._UCS" "P")
 (setvar "CMDECHO" CMDECHO)
 (setvar "ANGBASE" ANGBASE)
 (setvar "ANGDIR" ANGDIR)
 (setvar "OSMODE" OSMODE)
)