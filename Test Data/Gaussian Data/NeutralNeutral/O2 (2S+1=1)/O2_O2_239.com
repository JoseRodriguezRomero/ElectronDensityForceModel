%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_238.chk
%Chk=O2_O2_239.chk

#p ROCCSD(T,MaxCyc=350)/cc-pVTZ Guess=Read SCF=(VeryTight,MaxCycle=2500,CDIIS,VShift=10) 

O2_O2_239

0 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             10.381523          0.000000          0.000000
O              9.029143          0.000000          0.000000
