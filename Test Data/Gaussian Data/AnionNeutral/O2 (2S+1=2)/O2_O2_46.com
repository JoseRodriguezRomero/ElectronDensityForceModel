%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_45.chk
%Chk=O2_O2_46.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_46

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.265016          0.000000          0.000000
O              2.912636          0.000000          0.000000

