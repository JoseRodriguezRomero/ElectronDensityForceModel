%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_244.chk
%Chk=O2_O2_245.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_245

-1 6
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              7.082574          0.000000          0.000000
O              5.730194          0.000000          0.000000

