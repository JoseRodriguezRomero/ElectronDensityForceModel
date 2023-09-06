%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_158.chk
%Chk=O2_O2_159.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_159

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              8.116150          0.000000          0.000000
O              6.763770          0.000000          0.000000

