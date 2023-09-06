%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_197.chk
%Chk=O2_O2_198.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_198

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.417120          0.000000          0.000000
O              5.064740          0.000000          0.000000

