%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_156.chk
%Chk=O2_O2_157.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_157

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              8.059516          0.000000          0.000000
O              6.707136          0.000000          0.000000

