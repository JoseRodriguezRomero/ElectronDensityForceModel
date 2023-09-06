%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_38.chk
%Chk=O2_O2_39.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_39

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.718090          0.000000          0.000000
O              3.365710          0.000000          0.000000

