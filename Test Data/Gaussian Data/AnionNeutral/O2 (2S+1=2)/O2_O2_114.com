%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_113.chk
%Chk=O2_O2_114.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_114

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.227799          0.000000          0.000000
O              3.875419          0.000000          0.000000

