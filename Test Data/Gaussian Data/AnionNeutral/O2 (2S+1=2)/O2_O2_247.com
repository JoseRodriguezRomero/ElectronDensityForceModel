%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_246.chk
%Chk=O2_O2_247.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_247

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.110891          0.000000          0.000000
O              5.758511          0.000000          0.000000

