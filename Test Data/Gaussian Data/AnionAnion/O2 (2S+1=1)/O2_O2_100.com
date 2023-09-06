%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_99.chk
%Chk=O2_O2_100.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_100

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.029579          0.000000          0.000000
O              3.677199          0.000000          0.000000

