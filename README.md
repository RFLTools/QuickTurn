# QuickTurn
AutoLisp Vehicle Tracking

Purpose:  Model swept path of vehicles in 2D.

Notes:  Use "RunMe.cmd" to combine all necessary files to single "LoadQuickTurn.lsp"

Status:

First cut appears to be work - still needing full eval and qc

All you need to run is "LoadQuickTurn.lsp" unless you want to eval code.  If so copy the entire project and use "RunMe.cmd"

Background:

QuickTurn breaks the path into a series of short straightline segments.  For each straight line it calculates a new veehicle angle based on the previus angle (relative to the straight path segment).  The straight line formulae is defined by the straight line formual found on page 2052 of:

Mathematical and Computer Modelling
Volume 49, Issues 9–10, May 2009, Pages 2049–2060
http://www.sciencedirect.com/science/article/pii/S0895717708003804

A second path is generated for the trailing vehicle based on the hitch point of the forward vehicle.  This process is repeated for additional vehicles.
