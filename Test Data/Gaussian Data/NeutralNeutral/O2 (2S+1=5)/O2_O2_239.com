%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_238.chk
%Chk=O2_O2_239.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_239

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             10.381523          0.000000          0.000000
O              9.029143          0.000000          0.000000

