%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_225.chk
%Chk=O2_O2_226.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_226

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             10.013400          0.000000          0.000000
O              8.661020          0.000000          0.000000

