%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_232.chk
%Chk=O2_O2_233.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_233

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             10.211620          0.000000          0.000000
O              8.859240          0.000000          0.000000

