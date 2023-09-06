%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_121.chk
%Chk=O2_O2_122.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_122

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.068415          0.000000          0.000000
O              5.716035          0.000000          0.000000

