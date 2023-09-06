%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_243.chk
%Chk=O2_O2_244.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_244

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.068415          0.000000          0.000000
O              5.716035          0.000000          0.000000

