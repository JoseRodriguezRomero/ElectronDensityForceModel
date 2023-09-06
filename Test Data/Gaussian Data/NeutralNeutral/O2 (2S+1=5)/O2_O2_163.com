%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_162.chk
%Chk=O2_O2_163.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_163

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              8.229419          0.000000          0.000000
O              6.877039          0.000000          0.000000

