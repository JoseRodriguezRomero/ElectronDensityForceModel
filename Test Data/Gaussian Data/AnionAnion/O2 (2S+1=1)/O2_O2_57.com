%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_56.chk
%Chk=O2_O2_57.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_57

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.420760          0.000000          0.000000
O              3.068380          0.000000          0.000000

