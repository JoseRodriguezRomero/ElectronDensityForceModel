%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_234.chk
%Chk=O2_O2_235.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_235

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             10.268255          0.000000          0.000000
O              8.915875          0.000000          0.000000

