%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_286.chk
%Chk=O2_O2_287.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_287

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.677234          0.000000          0.000000
O              6.324854          0.000000          0.000000

