%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_236.chk
%Chk=O2_O2_237.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_237

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             10.324889          0.000000          0.000000
O              8.972509          0.000000          0.000000

