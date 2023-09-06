%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_110.chk
%Chk=O2_O2_111.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_111

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.756926          0.000000          0.000000
O              5.404546          0.000000          0.000000

