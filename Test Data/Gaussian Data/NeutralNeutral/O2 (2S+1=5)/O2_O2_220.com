%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_219.chk
%Chk=O2_O2_220.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_220

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              9.843497          0.000000          0.000000
O              8.491117          0.000000          0.000000

