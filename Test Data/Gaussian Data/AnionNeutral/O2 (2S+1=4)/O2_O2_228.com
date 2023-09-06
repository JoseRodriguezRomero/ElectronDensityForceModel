%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_227.chk
%Chk=O2_O2_228.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_228

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.841878          0.000000          0.000000
O              5.489498          0.000000          0.000000

