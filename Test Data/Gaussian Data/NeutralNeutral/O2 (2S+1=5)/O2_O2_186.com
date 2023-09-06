%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_185.chk
%Chk=O2_O2_186.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_186

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              8.880713          0.000000          0.000000
O              7.528333          0.000000          0.000000

