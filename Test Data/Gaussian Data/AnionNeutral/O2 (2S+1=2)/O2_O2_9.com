%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_8.chk
%Chk=O2_O2_9.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_9

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.741148          0.000000          0.000000
O              2.388768          0.000000          0.000000

