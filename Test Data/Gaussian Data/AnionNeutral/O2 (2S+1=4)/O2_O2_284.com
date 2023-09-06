%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_283.chk
%Chk=O2_O2_284.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_284

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.634758          0.000000          0.000000
O              6.282378          0.000000          0.000000

