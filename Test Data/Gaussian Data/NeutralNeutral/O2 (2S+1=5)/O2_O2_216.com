%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_215.chk
%Chk=O2_O2_216.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_216

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              9.730228          0.000000          0.000000
O              8.377848          0.000000          0.000000

