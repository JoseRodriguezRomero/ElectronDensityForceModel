%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_177.chk
%Chk=O2_O2_178.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_178

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              8.654176          0.000000          0.000000
O              7.301796          0.000000          0.000000

