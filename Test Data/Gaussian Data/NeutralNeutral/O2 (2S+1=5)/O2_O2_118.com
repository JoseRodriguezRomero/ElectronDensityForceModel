%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_117.chk
%Chk=O2_O2_118.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_118

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.955146          0.000000          0.000000
O              5.602766          0.000000          0.000000

