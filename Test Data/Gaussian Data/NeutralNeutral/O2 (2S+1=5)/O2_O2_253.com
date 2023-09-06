%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_252.chk
%Chk=O2_O2_253.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_253

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             10.777963          0.000000          0.000000
O              9.425583          0.000000          0.000000

