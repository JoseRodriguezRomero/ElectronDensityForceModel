%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_88.chk
%Chk=O2_O2_89.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_89

-2 1
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              4.873835          0.000000          0.000000
O              3.521455          0.000000          0.000000

