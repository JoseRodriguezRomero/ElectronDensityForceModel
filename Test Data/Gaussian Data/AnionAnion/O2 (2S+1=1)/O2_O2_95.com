%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_94.chk
%Chk=O2_O2_95.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_95

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.958786          0.000000          0.000000
O              3.606406          0.000000          0.000000

