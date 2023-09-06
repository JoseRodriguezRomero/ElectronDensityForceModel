%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_174.chk
%Chk=O2_O2_175.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_175

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.091473          0.000000          0.000000
O              4.739093          0.000000          0.000000

