%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_151.chk
%Chk=O2_O2_152.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_152

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.765825          0.000000          0.000000
O              4.413445          0.000000          0.000000

