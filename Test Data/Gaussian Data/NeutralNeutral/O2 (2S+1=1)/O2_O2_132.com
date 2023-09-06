%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_131.chk
%Chk=O2_O2_132.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_132

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.351587          0.000000          0.000000
O              5.999207          0.000000          0.000000

