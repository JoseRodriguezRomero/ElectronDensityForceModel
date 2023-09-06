%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_187.chk
%Chk=O2_O2_188.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_188

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              8.937348          0.000000          0.000000
O              7.584968          0.000000          0.000000

