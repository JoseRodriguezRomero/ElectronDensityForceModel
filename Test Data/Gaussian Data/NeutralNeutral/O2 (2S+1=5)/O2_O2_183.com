%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_182.chk
%Chk=O2_O2_183.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_183

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              8.795762          0.000000          0.000000
O              7.443382          0.000000          0.000000

