%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_152.chk
%Chk=O2_O2_153.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_153

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.779984          0.000000          0.000000
O              4.427604          0.000000          0.000000

