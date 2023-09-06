%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_179.chk
%Chk=O2_O2_180.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_180

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              8.710810          0.000000          0.000000
O              7.358430          0.000000          0.000000

