%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_239.chk
%Chk=O2_O2_240.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_240

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             10.409840          0.000000          0.000000
O              9.057460          0.000000          0.000000

