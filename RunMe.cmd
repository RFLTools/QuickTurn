@echo off
rem
rem Simple copy batch to create combines lsp file
rem
if exist RunMe.lsp del LoadQuickTurn.lsp
rem
COPY ".\QTGetD.lsp" + ^
     ".\QTGetPList.lsp" + ^
     ".\QTMAke\QTMake.lsp" + ^
     ".\QTMAke\QTMakeOUT.lsp" + ^
     ".\QTMAke\QTMakeSLB.lsp" + ^
     ".\QTMAke\QTMakeOUT.lsp" ^
     ".\LoadQuickTurn.lsp"
pause