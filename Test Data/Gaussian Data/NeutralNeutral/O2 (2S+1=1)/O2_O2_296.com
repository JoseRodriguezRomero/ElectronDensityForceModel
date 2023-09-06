%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_295.chk
%Chk=O2_O2_296.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_296

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.995602          0.000000          0.000000
O             10.643222          0.000000          0.000000

