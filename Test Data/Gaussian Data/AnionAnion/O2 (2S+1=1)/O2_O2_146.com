%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_145.chk
%Chk=O2_O2_146.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_146

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.680874          0.000000          0.000000
O              4.328494          0.000000          0.000000

