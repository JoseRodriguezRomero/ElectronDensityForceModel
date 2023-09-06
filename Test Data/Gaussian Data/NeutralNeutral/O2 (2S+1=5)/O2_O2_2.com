%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_1.chk
%Chk=O2_O2_2.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_2

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              3.670355          0.000000          0.000000
O              2.317975          0.000000          0.000000

