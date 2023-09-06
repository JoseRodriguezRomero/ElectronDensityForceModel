%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_122.chk
%Chk=O2_O2_123.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_123

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.355227          0.000000          0.000000
O              4.002847          0.000000          0.000000

