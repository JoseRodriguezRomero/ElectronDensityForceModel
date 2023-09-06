%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_282.chk
%Chk=O2_O2_283.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_283

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.620600          0.000000          0.000000
O              6.268220          0.000000          0.000000

