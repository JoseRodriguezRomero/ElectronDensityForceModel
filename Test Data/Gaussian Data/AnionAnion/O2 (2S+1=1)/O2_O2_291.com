%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_290.chk
%Chk=O2_O2_291.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_291

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.733868          0.000000          0.000000
O              6.381488          0.000000          0.000000

