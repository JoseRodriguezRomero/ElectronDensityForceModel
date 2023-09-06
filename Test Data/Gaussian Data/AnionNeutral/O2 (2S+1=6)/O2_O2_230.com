%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_229.chk
%Chk=O2_O2_230.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_230

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.870195          0.000000          0.000000
O              5.517815          0.000000          0.000000

