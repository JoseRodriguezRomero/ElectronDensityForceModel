%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_107.chk
%Chk=O2_O2_108.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_108

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.671975          0.000000          0.000000
O              5.319595          0.000000          0.000000

