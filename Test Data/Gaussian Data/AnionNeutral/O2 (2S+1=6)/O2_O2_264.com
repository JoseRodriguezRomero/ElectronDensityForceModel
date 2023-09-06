%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_263.chk
%Chk=O2_O2_264.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_264

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.351587          0.000000          0.000000
O              5.999207          0.000000          0.000000

