%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_276.chk
%Chk=O2_O2_277.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_277

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.535648          0.000000          0.000000
O              6.183268          0.000000          0.000000

