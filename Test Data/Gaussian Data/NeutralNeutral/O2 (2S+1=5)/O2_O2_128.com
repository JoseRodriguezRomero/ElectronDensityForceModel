%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_127.chk
%Chk=O2_O2_128.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_128

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.238318          0.000000          0.000000
O              5.885938          0.000000          0.000000

