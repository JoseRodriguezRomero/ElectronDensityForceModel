%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_65.chk
%Chk=O2_O2_66.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_66

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              5.482654          0.000000          0.000000
O              4.130274          0.000000          0.000000

