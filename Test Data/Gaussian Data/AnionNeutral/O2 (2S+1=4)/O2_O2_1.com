%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_0.chk
%Chk=O2_O2_1.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_1

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.627880          0.000000          0.000000
O              2.275500          0.000000          0.000000

