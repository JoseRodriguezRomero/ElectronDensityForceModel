%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_153.chk
%Chk=O2_O2_154.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_154

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.794143          0.000000          0.000000
O              4.441763          0.000000          0.000000

