%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_98.chk
%Chk=O2_O2_99.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_99

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.015421          0.000000          0.000000
O              3.663041          0.000000          0.000000

