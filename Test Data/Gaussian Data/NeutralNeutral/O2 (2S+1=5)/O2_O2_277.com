%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_276.chk
%Chk=O2_O2_277.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_277

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O             11.457575          0.000000          0.000000
O             10.105195          0.000000          0.000000

