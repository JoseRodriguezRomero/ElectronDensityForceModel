%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_83.chk
%Chk=O2_O2_84.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_84

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.803042          0.000000          0.000000
O              3.450662          0.000000          0.000000

