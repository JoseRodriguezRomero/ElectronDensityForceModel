%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_114.chk
%Chk=O2_O2_115.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_115

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.241958          0.000000          0.000000
O              3.889578          0.000000          0.000000

