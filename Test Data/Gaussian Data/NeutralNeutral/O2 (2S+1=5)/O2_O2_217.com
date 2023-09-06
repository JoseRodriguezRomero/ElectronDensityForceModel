%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_216.chk
%Chk=O2_O2_217.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_217

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              9.758546          0.000000          0.000000
O              8.406166          0.000000          0.000000

