%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_168.chk
%Chk=O2_O2_169.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_169

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              8.399322          0.000000          0.000000
O              7.046942          0.000000          0.000000
