%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_253.chk
%Chk=O2_O2_254.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_254

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.210001          0.000000          0.000000
O              5.857621          0.000000          0.000000

