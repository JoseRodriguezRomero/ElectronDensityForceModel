%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_204.chk
%Chk=O2_O2_205.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_205

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              9.418740          0.000000          0.000000
O              8.066360          0.000000          0.000000

