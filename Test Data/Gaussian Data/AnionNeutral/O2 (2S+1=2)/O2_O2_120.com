%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_119.chk
%Chk=O2_O2_120.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_120

-1 2
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.312751          0.000000          0.000000
O              3.960371          0.000000          0.000000

