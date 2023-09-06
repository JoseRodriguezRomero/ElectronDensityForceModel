%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_74.chk
%Chk=O2_O2_75.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_75

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.737508          0.000000          0.000000
O              4.385128          0.000000          0.000000

