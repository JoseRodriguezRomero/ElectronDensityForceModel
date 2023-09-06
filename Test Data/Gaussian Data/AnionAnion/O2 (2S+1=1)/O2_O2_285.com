%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_284.chk
%Chk=O2_O2_285.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_285

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.648917          0.000000          0.000000
O              6.296537          0.000000          0.000000

