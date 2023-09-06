%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_186.chk
%Chk=O2_O2_187.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_187

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.261376          0.000000          0.000000
O              4.908996          0.000000          0.000000

