%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_200.chk
%Chk=O2_O2_201.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_201

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              9.305471          0.000000          0.000000
O              7.953091          0.000000          0.000000

