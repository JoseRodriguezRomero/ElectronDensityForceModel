%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_136.chk
%Chk=O2_O2_137.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_137

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.553447          0.000000          0.000000
O              4.201067          0.000000          0.000000

