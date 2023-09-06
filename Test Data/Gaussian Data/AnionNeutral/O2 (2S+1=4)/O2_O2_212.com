%NProcShared=6
%Mem=5GB
%OldChk=O2_O2_211.chk
%Chk=O2_O2_212.chk

#p ROCCSD(T)/cc-pVTZ Guess=Read SCF=(VeryTight,CDIIS,VShift=10) 

O2_O2_212

-1 4
O              0.676190          0.000000          0.000000
O             -0.676190          0.000000          0.000000
O              6.615340          0.000000          0.000000
O              5.262960          0.000000          0.000000

