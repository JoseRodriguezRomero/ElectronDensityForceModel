%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_9.chk
%Chk=O2_O2_10.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_10

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.755307          0.000000          0.000000
O              2.402927          0.000000          0.000000

