%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_95.chk
%Chk=O2_O2_96.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_96

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.332169          0.000000          0.000000
O              4.979789          0.000000          0.000000

