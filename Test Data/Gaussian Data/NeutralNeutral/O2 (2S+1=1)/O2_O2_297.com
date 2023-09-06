%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_296.chk
%Chk=O2_O2_297.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=100) 

O2_O2_297

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             12.023919          0.000000          0.000000
O             10.671539          0.000000          0.000000

