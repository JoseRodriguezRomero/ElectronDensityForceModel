%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_248.chk
%Chk=O2_O2_249.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_249

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             10.664695          0.000000          0.000000
O              9.312315          0.000000          0.000000

