%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_178.chk
%Chk=O2_O2_179.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_179

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.148107          0.000000          0.000000
O              4.795727          0.000000          0.000000

