%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_59.chk
%Chk=O2_O2_60.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_60

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.312751          0.000000          0.000000
O              3.960371          0.000000          0.000000

