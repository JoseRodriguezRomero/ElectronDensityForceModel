%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_223.chk
%Chk=O2_O2_224.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_224

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.785243          0.000000          0.000000
O              5.432863          0.000000          0.000000
