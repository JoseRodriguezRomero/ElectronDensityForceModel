%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_112.chk
%Chk=O2_O2_113.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_113

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.813561          0.000000          0.000000
O              5.461181          0.000000          0.000000

