%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_22.chk
%Chk=O2_O2_23.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_23

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.939368          0.000000          0.000000
O              2.586988          0.000000          0.000000

