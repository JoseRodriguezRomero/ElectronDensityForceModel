%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_82.chk
%Chk=O2_O2_83.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_83

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.964046          0.000000          0.000000
O              4.611666          0.000000          0.000000
