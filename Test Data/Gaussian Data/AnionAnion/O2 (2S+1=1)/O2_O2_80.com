%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_79.chk
%Chk=O2_O2_80.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_80

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.746408          0.000000          0.000000
O              3.394028          0.000000          0.000000

