%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_232.chk
%Chk=O2_O2_233.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_233

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.912671          0.000000          0.000000
O              5.560291          0.000000          0.000000

