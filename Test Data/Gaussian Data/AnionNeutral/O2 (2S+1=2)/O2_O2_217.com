%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_216.chk
%Chk=O2_O2_217.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_217

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.686133          0.000000          0.000000
O              5.333753          0.000000          0.000000

