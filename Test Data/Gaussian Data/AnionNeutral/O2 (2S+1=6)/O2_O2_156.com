%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_155.chk
%Chk=O2_O2_156.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_156

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.822460          0.000000          0.000000
O              4.470080          0.000000          0.000000

