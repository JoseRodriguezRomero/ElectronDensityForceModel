%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_240.chk
%Chk=O2_O2_241.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_241

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.025939          0.000000          0.000000
O              5.673559          0.000000          0.000000

