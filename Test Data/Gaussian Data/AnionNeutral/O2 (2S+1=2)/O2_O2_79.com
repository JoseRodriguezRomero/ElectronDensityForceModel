%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_78.chk
%Chk=O2_O2_79.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_79

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.732249          0.000000          0.000000
O              3.379869          0.000000          0.000000

