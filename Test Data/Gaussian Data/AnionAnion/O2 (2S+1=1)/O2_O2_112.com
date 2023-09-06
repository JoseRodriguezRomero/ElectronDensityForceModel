%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_111.chk
%Chk=O2_O2_112.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_112

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.199482          0.000000          0.000000
O              3.847102          0.000000          0.000000

