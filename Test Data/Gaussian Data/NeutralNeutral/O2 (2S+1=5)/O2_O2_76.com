%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_75.chk
%Chk=O2_O2_76.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_76

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.765825          0.000000          0.000000
O              4.413445          0.000000          0.000000

