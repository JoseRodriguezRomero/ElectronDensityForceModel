%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_260.chk
%Chk=O2_O2_261.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_261

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.309111          0.000000          0.000000
O              5.956731          0.000000          0.000000

