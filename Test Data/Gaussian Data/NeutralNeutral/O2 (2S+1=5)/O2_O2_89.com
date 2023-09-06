%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_88.chk
%Chk=O2_O2_89.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_89

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.133949          0.000000          0.000000
O              4.781569          0.000000          0.000000

