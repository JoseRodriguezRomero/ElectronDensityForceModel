%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_161.chk
%Chk=O2_O2_162.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_162

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              8.201102          0.000000          0.000000
O              6.848722          0.000000          0.000000

