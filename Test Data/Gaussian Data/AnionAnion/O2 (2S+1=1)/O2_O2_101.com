%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_100.chk
%Chk=O2_O2_101.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_101

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.043738          0.000000          0.000000
O              3.691358          0.000000          0.000000

