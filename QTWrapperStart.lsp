;
;
;   Program written by Robert Livingston, 2016-05-16
;
;   C:QUICKTURN main routine
;
;   QTWrapperStart.lsp is the header wrapper for C:QUICKTURN
;
;
; C:QT is a shortcut for C:QUICKTURN
(defun C:QT ()
 (C:QUICKTURN)
)
(defun C:QUICKTURN (/ *error*
                      ; Variables
                      ANGBASE ANGDIR BLOCKSCALE C CMAX CMDECHO D D0 DG DH
                      ENT ENTFIRST ENTLIST FIRSTLOCKANG FLAG GETTURNANG LA LALIST LB LBLIST LOCKANG
                      QT:LOCKANGWARNING
                      NODE OSMODE P PLA PLB PLIST PLINELIST QTDLIST QTVLIST REP REP2 STA
                      STAMAX STEP TAN TMP WF WR
                      
                      ; Functions
                      QT:CIRCLE3P QT:COPY QT:DRAWENVELOPE QT:GETENVELOPE QT:GETPLIST QT:MAKETEMPBLOCK
                      QT:MOVEVEHICLE QT:NEWANG QT:NEWWHEELANG QT:PLACE QT:SETPATH QT:SETWHEELPATH QT:TPATH
                      QT:TWHEELS
                   )
 (command-s "._UNDO" "M")
 (command-s "._UCS" "W")
 (setq CMDECHO (getvar "CMDECHO"))
 (setvar "CMDECHO" 0)
 (setq OSMODE (getvar "OSMODE"))
 (setq ANGBASE (getvar "ANGBASE"))
 (setvar "ANGBASE" 0.0)
 (setq ANGDIR (getvar "ANGDIR"))
 (setvar "ANGDIR" 0)
 
 (setq QT:LOCKANGWARNING nil)

 (if (= nil QT:MSGPOPUP)
  (progn
   (setq QT:MSGPOPUP T)
   (alert (strcat "QUICKTURN - Vehicle Turn Movement Simulator\n\n"
                  "The author makes no warranty, representation or guarantee, expressed,\n"
                  "implied or statutory, as to the accuracy, reliability, suitability,\n"
                  "function, or results derived from QUICKTURN.  The author shall incur\n"
                  "no liability, loss or damage caused or alleged to be caused directly\n"
                  "or indirectly by QUICKTURN, including, but not limited to, any\n"
                  "interruption of service, loss of business or anticipated profits, lost\n"
                  "savings, or incidental, special, punitive or consequential damages\n"
                  "resulting from the use or operation of QUICKTURN even if caused by the\n"
                  "negligence of the author and even if the author had the knowledge of\n"
                  "the possibility of such liability, loss, or damage.  All computer\n"
                  "program results require professional interpretation and the author\n"
                  "makes no warranty for results obtained by using QUICKTURN.\n\n"
                   "By clicking OK below you agree to be bound by these conditions."
          )
   )
  )
 )

 (defun *error* (msg)
  (foreach NODE QTVLIST (redraw (car NODE) 1))
  (foreach NODE QTVLIST (entdel (last NODE)))
  (command-s "._UCS" "P")
  (setvar "CMDECHO" CMDECHO)
  (setvar "ANGBASE" ANGBASE)
  (setvar "ANGDIR" ANGDIR)
  (setvar "OSMODE" OSMODE)
  ;(setq *error* nil)
  (print msg)
 )

 (defun TAN (X)
  (/ (sin X) (cos X))
 )
