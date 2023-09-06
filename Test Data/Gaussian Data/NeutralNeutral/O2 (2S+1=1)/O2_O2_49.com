%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_48.chk
%Chk=O2_O2_49.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_49

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.001262          0.000000          0.000000
O              3.648882          0.000000          0.000000

