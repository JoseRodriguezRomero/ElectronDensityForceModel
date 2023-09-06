%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_51.chk
%Chk=O2_O2_52.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_52

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.086214          0.000000          0.000000
O              3.733834          0.000000          0.000000

