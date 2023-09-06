%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_243.chk
%Chk=O2_O2_244.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_244

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             10.523109          0.000000          0.000000
O              9.170729          0.000000          0.000000

