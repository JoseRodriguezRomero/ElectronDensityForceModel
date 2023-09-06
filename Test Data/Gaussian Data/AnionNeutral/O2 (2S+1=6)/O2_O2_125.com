%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_124.chk
%Chk=O2_O2_125.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_125

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.383544          0.000000          0.000000
O              4.031164          0.000000          0.000000

