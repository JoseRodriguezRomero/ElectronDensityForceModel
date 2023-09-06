%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_170.chk
%Chk=O2_O2_171.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_171

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              8.455956          0.000000          0.000000
O              7.103576          0.000000          0.000000

