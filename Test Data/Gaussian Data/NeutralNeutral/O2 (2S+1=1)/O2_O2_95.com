%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_94.chk
%Chk=O2_O2_95.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_95

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.303852          0.000000          0.000000
O              4.951472          0.000000          0.000000

