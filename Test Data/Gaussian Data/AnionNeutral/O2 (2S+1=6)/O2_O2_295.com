%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_294.chk
%Chk=O2_O2_295.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_295

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.790503          0.000000          0.000000
O              6.438123          0.000000          0.000000

