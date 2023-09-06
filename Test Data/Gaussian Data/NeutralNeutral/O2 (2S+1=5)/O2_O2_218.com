%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_217.chk
%Chk=O2_O2_218.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_218

0 5
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              9.786863          0.000000          0.000000
O              8.434483          0.000000          0.000000

