%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_255.chk
%Chk=O2_O2_256.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_256

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             10.862915          0.000000          0.000000
O              9.510535          0.000000          0.000000
